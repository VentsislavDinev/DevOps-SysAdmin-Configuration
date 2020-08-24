Configuration ServerConfiguration {

    # Search for and imports Service, File, and Registry from the module PSDesiredStateConfiguration.
    Import-DSCResource -ModuleName PSDesiredStateConfiguration -Name Service, File, Registry

    Import-DscResource -ModuleName xWebAdministration
    
    # Search for and import Resource1 from the module that defines it.
    # If only –Name parameter is used then resources can belong to different PowerShell modules as well.
    # TimeZone resource is from the ComputerManagementDSC module which is not installed by default.
    # As a best practice, list each requirement on a different line if possible.  This makes reviewing
    # multiple changes in source control a bit easier.
    Import-DSCResource -Name File
    Import-DSCResource -Name TimeZone

    # Search for and import all DSC resources inside the module PSDesiredStateConfiguration.
    # When specifying the modulename parameter, it is a requirement to list each on a new line.
    Import-DSCResource -ModuleName PSDesiredStateConfiguration
    # In PowerShell 5.0 and later, you can specify a ModuleVersion parameter
    Import-DSCResource -ModuleName ComputerManagementDsc -ModuleVersion 6.0.0.0

    # It is best practice to explicitly import all resources used in your Configuration.
    # This includes resources that are imported automatically, like WindowsFeature.
    Import-DSCResource -Name WindowsFeature

    # with this module you can configure your clusters
    Import-DscResource -ModuleName xFailOverCluster -ModuleVersion 1.1

    # Please use param for reuse your code 
    param {
        [string[]]
        $ComputerName = "US servers"
        [ValidateSet("Running","Stopped")]
        [String]
        $State="Running",
    }
    #Please if you want use for only one node location please use : $ComputerName / "Server name"
    Node @($ComputerName, "Germany Server" {
        WindowsFeature FeatureInstance {
            Ensure = "Present"
            Name ="Bitlocker"
        }

        WindowsFeature ThrdFeatureInstace {
            Name ="RSAT"
            Ensure = "Present"
        }

        File SampleFile {
            DestinationPath = "C:\Temp\HelloWorld.txt"
            Ensure = "Present"
            Contents = "Hello Ventsi from DSC!"
        }

        xCluster Clusters {
            Name =  "US cluster"
            StaticIPAddress = '10.3.3.10'
            DomainAdministratorCredential = Get-Credential
        }

        WindowsFeature SecondFeatureInstance{
            Name = "IIS Server"
            Ensure = 'Present'
        }
    }

    Node $AllNodes.NodeName
    {
        Registry CmdPath
        {
            Key                  = 'HKEY_CURRENT_USER\SOFTWARE\Microsoft\Command Processor'
            ValueName            = 'DefaultColor'
            ValueData            = '1F'
            ValueType            = 'DWORD'
            Ensure               = 'Present'
            Force                = $true
            Hex                  = $true
            PsDscRunAsCredential = Get-Credential
        }

        Service 'Spooler'
        {
            Name = 'Spooler'
            State = 'Running'
        }


        #loop all service from array 
        foreach ($service in $(Get-Service))
        {
            Service $service.Name
            {
                Name = $service.Name
                State = $service.Status
                StartType = $service.StartType
            }
        }


        foreach ($computer in @($ComputerName)) {
            Node $computer
            {
                Service "Spooler"
                {
                    Name = "Spooler"
                    State = "Started"
                }
            }
        }

    }
      
    $MyData =
    @{
        AllNodes =
        @(
            @{
                NodeName = "VM-1"
                Role     = "WebServer"
                SiteContents = "C:\Site1"
                SiteName     = "Website1"
                FeatureName = 'Web-Server'
            },


            @{
                NodeName = "VM-2"
                Role     = "SQLServer"
                FeatureName = 'Web-Server'
            },


            @{
                NodeName = "VM-3"
                Role     = "WebServer"
                SiteContents = "C:\Site2"
                SiteName     = "Website3"
                FeatureName = 'Web-Server'
            }
        );

        NonNodeData = ""
    }

    Node $AllNodes.Where(@_.Role -eq "WebServer").NodeName
    {
        WindowsFeature IISInstall {
            Ensure = "Present"
            Name = "Web-server"
        }
    }

    Node $AllNodes.Where(@_.Role -eq "VMHost").NodeName {
        WindowsFeature HyperVInstall {
            Ensure = 'Present'
            Name   = 'Hyper-V'
        }
    }


    $configData = @{
        AllNodes = @(
            @{
                NodeName             = 'localhost';
                PSDscAllowDomainUser = $true
                CertificateFile      = 'C:\publicKeys\targetNode.cer'
                Thumbprint           = '7ee7f09d-4be0-41aa-a47f-96b9e3bdec25'
            }
        )
    }

}