# install RSAT-AD-PowerShell windows feature 
Install-WindowsFeature RSAT-AD-PowerShell 
# install windows compatibility module
Install-Module -Name WindowsCompatibility 
# import windows compatibility module
Import-Module -Name WindowsCompatibility
# import active directory module
Import-Module -Name ActiveDirectory 
# new session for s1 
Enter-PSession s1 
#now we create sample veriable for reuse
$S = New-PSession -ComputerName s1 
Import-Module -PSession $S -Name ActiveDirectory 

#Export the remote AD module to a local module 
#Create new session with PC name s2 
$S1 = New-PSession -ComputerName s2 
# Export Remote active directory 
Export-PSession - Session $S1 -Module ActiveDirectory -OutputModule RemoteAD
#remove session for pc s1
Remove-PSession -Session $S1 
# module import Remote Active directory
Import-Module RemoteAD


#now we install AD DS, DNS and DHCP 
#Install AD DS windows feature with managed tools 
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

#if you want to get info for AD DS module 
Get-Command -Module ADDSDeployment 

# now we install AD DS forest with domain name sample.local
Install-ADDSForest -DomainName "sample.local"


#now get AD Domain information  with format table  with host name, state, name and account name 
Get-ADDomain  -Format-Table DNSHostName, Enabled, Name, SamAccountName


#now create sample AD User 
New-AdUser -Name "vdinev" -AccountPassword (Read-Host -AsSecureString Za-14-rzaq) -PassThru | Enable-AdAccount

#now install DNS feature from windows server 
Install-WindowsFeature DNS -IncludeManagementTools

#add primary domain zone
Add-DnsServerPrimaryZone -NetworkID 192.168.2.2/24 -ZoneFile "192.168.0.2.in-addr.arpa.dns"

#add DNS server forward 
Add-DnsServerForward -IPAddress 8.8.8.8 -PassTru

#test dns server 
Test-DnsServer -IPAddress 192.168.0.2 -ZoneName "sample.local"

#configure staic IP address for Windows server 
New-NetIpAddress -IntefaceIndex 2 -IPAddress 192.168.2.2 -PrefixLength 24 -DefaultGateway   192.168.2.1

#install DHCP server 

Install-WindowsFeature DHCP -IncludeManagementTools

# with netsh add security group 
# netsh dhcp add secutirygroups 

#Configure subnet scope and exclusion
Add-DHCPServerv4Scope -Name "Employee Scope" -StartRange  192.168.2.9 -EndRage 192.168.64.24 -SubnetMask 255.255.255.0 -State Active 

#Set scope with lease 
Set-DhcpServerv4Scope -ScopeId 192.168.0.2 -LeaseDuration 1.00:00:00



#set DHCP operation value 
Set-DHCPServerv4OptionValue -ScopeId 192.168.0.2 -DNSDomain sample.local -DNSServer 192.168.2.2 -Router 192.168.2.1

# Add DHCP server to DC 
Add-DhcpServerInDC  -DnsName sample.local -IpAddress 192.168.2.2

# get DHCP server scope settings 
Get-DhcpServerv4Scope

#Configure Active directory with group policy 

#get Group policy command 
Get-Command -Module GroupPolicy

#Create GPO 
New-GPO -Name "ScreenSaverTimeOut" -Comment "Set the time to 400 seconds"

#set group policy value
Set-GPRegistryValue -Name "ScreenSaverTimeOut" -Key "HKCU\Software\Policies\Microsoft\Windows\Control Panel\Desktop" -ValueMame ScreenSaveTimeOut -Type String -Value 400

# new GP link with organization unit/Domain/Site 
New-GPLink -Name "ScreenSaverTimeOut" -Target "ou=people,dc=pagr,dc=inet"

#get GPO information with HTML report 
Get-GPO -Name "ScreenSaverTimeOut" | Get-GPOReport -ReportType HTML -Path $Home\Reort.html

#show report.html page with command 
invoke-item $Home\report.html

#configura inheritance group policy 
Get-GPInheritance -Target "ou=people,dc=pagr,dc=inet"

#block ingeritance group policy 
Set-GPInheritance -Target "ou=people,dc=pagr,dc=inet" -IsBlocked 1

# enforce group policy 
Set-GPLink -Name "Default Domain Policy" -Target "dc=pagr,dc=inet" -Enforced Yes

# select GPLink 
Get-GPInheritance -Target "ou=people,dc=pagr,dc=inet" | Select InheritedGpoLinks

#Set GP none permission 
Set-GPPermission -Name "ScreenSaverTimeOut" -TargetName "Authenticated Users" -TargetType User -PermissionLevel None

#Set GP permission GPORead 
Set-GPPermission -Name "ScreenSaverTimeOut" -TargetName "Authenticated Users" -TargetType User -PermissionLevel GPORead 

#set GP permission GPOApply 
Set-GPPermission -Name "ScreenSaverTimeOut" -TargetName "Petra" -TargetType User -PermissionLevel GPOApply