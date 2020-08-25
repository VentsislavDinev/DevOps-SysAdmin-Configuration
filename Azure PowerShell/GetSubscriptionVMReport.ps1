#Provide the subscription Id where the VMs reside
$subscriptionId = ""

# Provide the name of the csv file to be exported
$reportName = "sample.csv"

Select-AzSubscription $subscriptionId
$report = $()
$vms = Get-AzVM
$publicIps = Get-AzPublicIpAddress 
$nics = Get-NetworkInterface  | ?{ $_.VirtualMachine -NE $null}
foreach ($nic in $nics) {
    $info = "" | Select VmName, ResourceGroupName, Region, VmSize, VirtualNetwork, Subnet, PrivateIpAddress, OsType, PublicIPAddress, NicName, ApplicationSecurityGroup 
    $vm = $vms | ? -Property id -eq $nic.VirtualMachine.Id
    foreach ($publicIp  in $publicIps) {
        if ($nic.IpConfigurations.id -eq $publicIp.ipconfiguration.Id) {
            $info.PublicIPAddress = $publicIp.ipaddress
        }
    }
    $info.OsType = $vm.StorageProfile.OsDisk.OsType
    $info.VMName = $vm.name
    $info.ResourceGroupName = $vm.ResourceGroupName 
    $info.Region = $vm.Location 
    $info.VmSize = $vm.HardwareProfile.VmSize
    $info.VirtualNetwork = $nic.IpConfigurations.subnet.Id.Split("/")[-3] 
    $info.Subnet = $nic.IpConfigurations.subnet.Id.Split("/")[-1] 
    $info.PrivateIpAddress = $nic.IpConfigurations.PrivateIpAddress 
    $info.NicName = $nic.Name 
    $info.ApplicationSecurityGroup = $nic.IpConfigurations.ApplicationSecurityGroups.Id 
    $report+=$info 
}

$report | ft VmName,  ResourceGroupName, Region, VmSize, VirtualNetwork, Subnet, PrivateIpAddress, OsType, PublicIPAddress, NicName, ApplicationSecurityGroup 
$report | Export-CSV "$home/$reportName"