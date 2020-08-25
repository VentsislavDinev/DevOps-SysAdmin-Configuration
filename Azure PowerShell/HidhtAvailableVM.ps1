# create sample Load balance trafic between  higly available VM 

# variable for resource group
$rgName = "SampleResourceGroup"

# variable for location 
$location = "westeurope"

# create user object
$cred = Get-Credential -Message "set username and password for the VM"

# create a resource group 
New-AzResourcceGroup -Name $rgName -Location $location

# create a virtual network
$subnet = New-AzVirtualNetwork -ResourceGroupName $rgName -Name 'subnet' -AddressPrefix 192.168.1.0/24

$vnet = New-AzVirtualNetwork -ResourceGroupName $rgName -Name "vnet" ` 
    -AddressPrefix 192.168.0.0/16 -Location $location -Subnet $subnet

# create a public IP address 
$publicIp = New-AzPublicIpAddress -ResourceGroupName $rgName -Name "publicIp" `
    -Location $location -AllocationMethod Dynamic 

# create a front-end IP configuration for the website
$feip = New-AzLoadBalancerFrontendIpConfig  -Name 'froneEndPool' -PublicIpAddress $publicIp


# create a back-end address pool 
$bepool = New-AzLoadBalancerBackendAddressPoolConfig  -Name 'BackEndPool'

# create a load balancer probe on port 80
$probe = New-AzLoadBalancerProbeConfig  -Name 'HealthProbe' -Protocol Http -Port 80 -RequestPath / -IntevarlInSeconds 360 -ProbeCount 5

# create a load balancer rule for port 80
$rule = New-AzLoadBalancerRuleConfig  -Name 'LoadBalancerRuleWeb' -Protocol Tcp `
    -Probe $probe -FrontendPort 80 -BackendPort 80 `
    -FrontendIpConfiguration $feip -BackendAddressPool $bePool

# create a three NAT rules for port 3389
$natrule1 = New-AzLoadBalancerInboundNatRuleConfig  -Name 'LoadBalancerRDP1' -FrontendIpConfiguration $feip -Protocol Tcp -frontendPort 4221 -BackendPort 3389

$natrule2 = New-AzLoadBalancerInboundNatRuleConfig  -Name 'LoadBalacerRDP2' -FrontendIpConfiguration $feip  -Protocol tcp -frontendPort 4222 -BackendPort 3389

$natrule3 = New-AzLoadBalancerInboundNatRuleConfig -Name "LoadBalancerRDP3" -FrontendIpConfiguration $feip -Protocol tcp -frontendPort 4223 -BackendPort 3389
# create a load balancer 
$lb = New-AzLoadBalancer  -ResourceGroupName $rgName -Name "LoadBalancer" -Location $location -FrontendIpConfiguration $feip -BackendAddressPool $bepool -probe $probe -LoadBalancingRule  $rule -InboundNatRule $natrule1, $natrule2, $natrule3

#create a network security group rule for port 3389 
$rule1 = New-AzNetworkSecurityRuleConfig -Name 'NetworkSecurityGroupRuleRDP' -Description 'allow RDP' -Access Allow -Protocol Tcp -Direction Inbound -Priority 1000 -SourceAddressPrefix internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389

# create a network security group rule for port 80
$rule2 = New-AzNetworkSecurityRuleConfig -Name "NetworkSecurityGroupRuleHTTP" -Description 'allow HTTP' -Access Allow  -Protocol tcp -Direction Inbound -Priority 2000 -SourceAddressPrefix internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80

# create a network security group 
$nsg = New-AzNetworkSecurityGroup  -ResourceGroupName $rgName -Location $location -Name 'NetworkSecurityGroup' -SecurityRules $rule1, $rule2

# create a three virtual network cards and asscoiate with public IP address and NSG 
$nicVM1 = New-AzNetworkInterface  -ResourceGroupName $rgName -Location $location -Name "Nic1" -LoadBalancerBackendAddressPool $bePool -NetworkSecurityGroup $nsg -LoadBalancerInboundNatRule  $natrule1 -Subnet $vnet.Subnets[0]

$nicVM2 = New-AzNetworkInterface -ResourceGroupName $rgName -Location $location -Name "Nic2" -LoadBalancerBackendAddressPool $bepool -NetworkSecurityGroup $nsg -LoadBalancerInboundNatRule $natrule2 -Subnet $vnet.Subnets[0]

$nicVM2 = New-AzNetworkInterface -ResourceGroupName $rgName -Location $location -Name 'Nic3' -LoadBalancerBackendAddressPool $bepool -NetworkSecurityGroup $NSG -LoadBalancerInboundNatRule $natrule3 -Subnet $vnet.Subnets[0]

# create an availability  set
$as = New-AzAvailabilitySet  -ResourceGroupName $rgName -Location $location -Name 'AvailabilitySet' -Sku Aligned -PlatformFaultDomainCount 3 -PlatformUpdateDomainCount 3


# Create three virtual machines.

# ############## VM1 ###############

# Create a virtual machine configuration
$vmConfig = New-AzVMConfig -VMName 'VM1' -VMSize Standard_DS2 -AvailabilitySetId $as.Id | Set-AzVMOperatingSystem -Windows -ComputerName 'VM1' -Credential $cred |  Set-AzVMSourceImage -PublisherName MicrosoftWindowsServer -Offer WindowsServer -Skus 2016-datacenter -Version latest | Add-AzVMNetworkInterface  -Id $nicVM1.Id

# Configure SSH Keys
$sshPublicKey = Get-Content "$env:USERPROFILE\.ssh\id_rsa.pub"
Add-AzVMSshPublicKey -VM $vmConfig -KeyData $sshPublicKey -Path "/home/azureuser/.ssh/authorized_keys"

# create a virtual machine 
$vm1 = New-AzVM -ResourceGroupName $rgName -Location $location -VM $vmConfig

# Install and configure the OMS agent
$PublicSettings = New-Object psobject | Add-Member -PassThru NoteProperty workspaceId $omsId | ConvertTo-Json
$protectedSettings = New-Object psobject | Add-Member -PassThru NoteProperty workspaceKey $omsKey | ConvertTo-Json

Set-AzVMExtension -ExtensionName "OMS" -ResourceGroupName $resourceGroup -VMName $vm1 `
  -Publisher "Microsoft.EnterpriseCloud.Monitoring" -ExtensionType "OmsAgentForLinux" `
  -TypeHandlerVersion 1.0 -SettingString $PublicSettings ` -ProtectedSettingString $protectedSettings `
  -Location $location

# ############## VM2 ###############

# Create a virtual machine configuration
$vmConfig = New-AzVMConfig -VMName 'VM2' -VMSize Standard_DS2 -AvailabilitySetId $as.Id |   Set-AzVMOperatingSystem -Windows -ComputerName 'myVM2' -Credential $cred |   Set-AzVMSourceImage -PublisherName MicrosoftWindowsServer -Offer WindowsServer   -Skus 2016-Datacenter -Version latest | Add-AzVMNetworkInterface -Id $nicVM2.Id

# Configure SSH Keys
$sshPublicKey = Get-Content "$env:USERPROFILE\.ssh\id_rsa.pub"
Add-AzVMSshPublicKey -VM $vmConfig -KeyData $sshPublicKey -Path "/home/azureuser/.ssh/authorized_keys"


# Create a virtual machine
$vm2 = New-AzVM -ResourceGroupName $rgName -Location $location -VM $vmConfig

# Install and configure the OMS agent
$PublicSettings = New-Object psobject | Add-Member -PassThru NoteProperty workspaceId $omsId | ConvertTo-Json
$protectedSettings = New-Object psobject | Add-Member -PassThru NoteProperty workspaceKey $omsKey | ConvertTo-Json

Set-AzVMExtension -ExtensionName "OMS" -ResourceGroupName $resourceGroup -VMName $vm2 `
  -Publisher "Microsoft.EnterpriseCloud.Monitoring" -ExtensionType "OmsAgentForLinux" `
  -TypeHandlerVersion 1.0 -SettingString $PublicSettings ` -ProtectedSettingString $protectedSettings `
  -Location $location


# ############## VM3 ###############

# Create a virtual machine configuration
$vmConfig = New-AzVMConfig -VMName 'myVM3' -VMSize Standard_DS2 -AvailabilitySetId $as.Id | `
  Set-AzVMOperatingSystem -Windows -ComputerName 'myVM3' -Credential $cred | `
  Set-AzVMSourceImage -PublisherName MicrosoftWindowsServer -Offer WindowsServer `
  -Skus 2016-Datacenter -Version latest | Add-AzVMNetworkInterface -Id $nicVM3.Id

# Configure SSH Keys
$sshPublicKey = Get-Content "$env:USERPROFILE\.ssh\id_rsa.pub"
Add-AzVMSshPublicKey -VM $vmConfig -KeyData $sshPublicKey -Path "/home/azureuser/.ssh/authorized_keys"

# Create a virtual machine
$vm3 = New-AzVM -ResourceGroupName $rgName -Location $location -VM $vmConfig


# Install and configure the OMS agent
$PublicSettings = New-Object psobject | Add-Member -PassThru NoteProperty workspaceId $omsId | ConvertTo-Json
$protectedSettings = New-Object psobject | Add-Member -PassThru NoteProperty workspaceKey $omsKey | ConvertTo-Json

Set-AzVMExtension -ExtensionName "OMS" -ResourceGroupName $resourceGroup -VMName $vm3 `
  -Publisher "Microsoft.EnterpriseCloud.Monitoring" -ExtensionType "OmsAgentForLinux" `
  -TypeHandlerVersion 1.0 -SettingString $PublicSettings ` -ProtectedSettingString $protectedSettings `
  -Location $location
