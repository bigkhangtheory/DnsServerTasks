<#
    .SYNOPSIS
        The DnsServerADZone DSC resource manages an AD integrated zone on a Domain Name System (DNS) server.

    .DESCRIPTION
        The DnsServerADZone DSC resource manages an AD integrated zone on a Domain Name System (DNS) server.

    .PARAMETER ForwardLookupZones
        [System.Collections.Hashtable[]]
        Specify a list of DNS Forward Lookup Zones to create.

    .PARAMETER ForwardLookupZones::Name
        Key - [System.String]
        Name of the AD DNS zone

    .PARAMETER ForwardLookupZones::DynamicUpdate
        Write - [System.String]
        Allowed values: None, NonSecureAndSecure, Secure
        AD zone dynamic DNS update option. Defaults to 'NonSecureAndSecure'.

    .PARAMETER ForwardLookupZones::ReplicationScope
        Required - [System.String]
        Allowed values: Custom, Domain, Forest, Legacy
        AD zone replication scope option.

    .PARAMETER ForwardLookupZones::DirectoryPartitionName
        Write - [System.String]
        Name of the directory partition on which to store the zone. Use this parameter when the ReplicationScope parameter has a value of Custom.

    .PARAMETER ForwardLookupZones::Ensure
        Write - [System.String]
        Allowed values: Present, Absent
        Whether the DNS zone should be available or removed

    .PARAMETER ReverseLookupZones
        [System.String[]]
        Specify a list of IP supernets to create DNS reverse lookup zones.

        This configuration will divide a supernet into /24 subnets and define a DNS reverse lookup zone.

    .EXAMPLE
    {
        "ForwardLookupZones":  [
            {
                "ReplicationScope":  "Legacy",
                "Name":  "mapcom.local",
                "Ensure":  "Present"
            },
            {
                "ReplicationScope":  "Legacy",
                "Name":  "admin.internal",
                "Ensure":  "Present"
            },
            {
                "Ensure":  "Present",
                "Name":  "cm.lab"
            },
            {
                "Ensure":  "Present",
                "Name":  "comsol-pic.com"
            },
            {
                "Ensure":  "Present",
                "Name":  "cs.signius.com"
            },
            {
                "ReplicationScope":  "None",
                "Name":  "dchoice.local",
                "Ensure":  "Present"
            },
            {
                "ReplicationScope":  "Legacy",
                "Name":  "dev.db",
                "Ensure":  "Present"
            },
            {
                "ReplicationScope":  "Legacy",
                "Name":  "dev.internal",
                "Ensure":  "Present"
            },
            {
                "ReplicationScope":  "Legacy",
                "Name":  "dev1.db",
                "Ensure":  "Present"
            },
            {
                "ReplicationScope":  "Legacy",
                "Name":  "dev3.db",
                "Ensure":  "Present"
            },
            {
                "ReplicationScope":  "Legacy",
                "Name":  "dev4.db",
                "Ensure":  "Present"
            },
            {
                "ReplicationScope":  "Legacy",
                "Name":  "dev5.db",
                "Ensure":  "Present"
            },
            {
                "Ensure":  "Present",
                "Name":  "icanhazip.com"
            },
            {
                "ReplicationScope":  "Legacy",
                "Name":  "internal",
                "Ensure":  "Present"
            },
            {
                "Ensure":  "Present",
                "Name":  "mapcom.kube"
            }
        ],
        "ReverseLookupZones":  [
            "+10.51.0.0/16",
            "+10.101.0.0/16",
            "+10.160.0.0/16",
            "+10.170.0.0/16",
            "+10.180.0.0/16",
            "+10.190.0.0/16",
            "+10.200.0.0/20",
            "+10.200.16.0/20",
            "+10.200.224.0/20",
            "+10.254.0.0/16",
            "+172.16.96.0/20",
            "+172.16.0.0/20",
            "+172.16.16.0/20",
            "-172.18.19.0/24"
        ],
    }

    .INPUTS
        DSC Configuration Data

    .OUTPUTS
        DSC Managed Object Format (MOF) document

    .COMPONENT
        Desired State Configuration (DSC) Configurations

    .FUNCTIONALITY
        Define and configure instances of DSC resources for DNS Directory Services configuration

    .NOTES
        Requirements

        Target machine must be running Windows Server 2016 or later.

    .NOTES
        Author:     Khang M. Nguyen
        Company:    @bigkhangtheory
        Created:    2021-11

    .LINK
        https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerADZone

        https://docs.microsoft.com/en-us/powershell/scripting/dsc/configurations/configdata?view=powershell-7.2
#>
#Requires -Module DnsServerDsc



configuration ActiveDirectoryDnsZones
{
    param
    (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Hashtable[]]
        $ForwardLookupZones,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String[]]
        $ReverseLookupZones
    )

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName DnsServerDsc


    WindowsFeature AddDns
    {
        Name   = 'DNS'
        Ensure = 'Present'
    }

    WindowsFeature AddRsatDnsServer
    {
        Name      = 'RSAT-DNS-Server'
        Ensure    = 'Present'
        DependsOn = '[WindowsFeature]AddDns'
    }
    # set dependency reference
    $dependsOnRsatDnsServer = '[WindowsFeature]AddRsatDnsServer'


    <#
        Create DSC resources for DNS forward lookup zones
    #>
    foreach ($f in $ForwardLookupZones)
    {
        # remove case sensitivity of ordered Dictionary or Hashtable
        $f = @{ } + $f

        # this DNS forward lookup zone must have a name
        if (-not $f.ContainsKey('Name'))
        {
            throw 'ERROR: The Name property is not found.'
        }


        # if 'DynamicUpdate' not specified, default to 'NonSecureAndSecure'
        if (-not $f.ContainsKey('DynamicUpdate'))
        {
            $f.DynamicUpdate = 'NonSecureAndSecure'
        }



        # if 'ReplicationScope' not specified, default to 'Domain'
        if (-not $f.ContainsKey('ReplicationScope'))
        {
            $f.ReplicationScope = 'Domain'
        }



        # if not specified, ensure present
        if (-not $f.ContainsKey('Ensure'))
        {
            $f.Ensure = 'Present'
        }

        # this resource depends on installation of DNS Server
        $f.DependsOn = $dependsOnRsatDnsServer

        # create execution name for the resource
        $executionName = "$("$($f.Name)_$($f.DynamicUpdate)_$($f.ReplicationScope)" -replace '[()-.:\s]', '_')"

        $object = @"

        Creating DSC resource for DnsServerADZone with the following values:

            DnsServerADZone $($executionName)
            {
                Name                = '$($f.Name)'
                DynamicUpdate       = '$($f.DynamicUpdate)'
                ReplicationScope    = '$($f.ReplicationScope)'
                Ensure              = '$($f.Ensure)'
                DependsOn           = '$($f.DependsOn)'
            }

"@
        Write-Host "$object" -ForegroundColor Yellow




        $Splatting = @{
            ResourceName  = 'DnsServerADZone'
            ExecutionName = $executionName
            Properties    = $f
            NoInvoke      = $true
        }
        try
        {
            (Get-DscSplattedResource @Splatting).Invoke($f)
        }
        catch
        {
            throw 'ERROR: Failed to compile MOF document.'
        }

    } #end foreach
} #end configuration