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
    "ReverseLookupZones": [
        "10.51.0.0/16",
        "10.101.0.0/16",
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
    "ForwardLookupZones": [
        {
        "Scope": "Legacy",
        "ZoneNames": [
            "mapcom.local",
            "admin.internal",
            "dchoice.local",
            "dev.db",
            "dev.internal",
            "dev1.db",
            "dev3.db",
            "internal"
        ]
        },
        {
        "Scope": "Domain",
        "ZoneNames": [
            "cm.lab",
            "comsol-pic.com",
            "client4.signius.com",
            "cs.signius.com"
        ]
        }
    ]
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
        [ValidateSet('None', 'NonSecureAndSecure', 'Secure')]
        [System.String]
        $DynamicUpdate,

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
        # hashtable for building parameters
        $params = @{}

        # remove case sensitivity of ordered Dictionary or Hashtable
        $f = @{ } + $f

        # if 'DynamicUpdate' not specified, set default
        if (-not $PSBoundParameters.ContainsKey('DynamicUpdate'))
        {
            $params.DynamicUpdate = 'NonSecureAndSecure'
        }
        else
        {
            $params.DynamicUpdate = $DynamicUpdate
        }

        # set the replication scope of the zone
        if (-not $f.ContainsKey('Scope'))
        {
            throw 'ERROR: The property Scope is not defined.'
        }
        else
        {
            $params.ReplicationScope = $f.Scope
        }

        # the property 'ZoneName' must be specified, otherwise fail
        if (-not $f.ContainsKey('ZoneNames'))
        {
            throw 'ERROR: The property ZoneNames is not defined.'
        }

        # enumerate all zone names
        foreach ($z in $f.ZoneNames)
        {
            # assign the zone name
            $params.Name = $z

            # ensure the resource is Present
            $params.Ensure = 'Present'

            # this resource depends on installation of Dns Server
            $params.DependsOn = $dependsOnRsatDnsServer

            # create execution name for the resource
            $executionName = "$("$($params.Name)_$($params.DynamicUpdate)_$($params.ReplicationScope)" -replace '[()-.:\s]', '_')"

            $object = @"

        Creating DSC resource for DnsServerADZone with the following values:

            DnsServerADZone $($executionName)
            {
                Name                = '$($params.Name)'
                DynamicUpdate       = '$($params.DynamicUpdate)'
                ReplicationScope    = '$($params.ReplicationScope)'
                Ensure              = '$($params.Ensure)'
                DependsOn           = '$($params.DependsOn)'
            }

"@

            Write-Host "$object" -ForegroundColor Yellow

            # create DSC resource for DNS Server zones
            $Splatting = @{
                ResourceName  = 'DnsServerADZone'
                ExecutionName = $executionName
                Properties    = $params
                NoInvoke      = $true
            }
            (Get-DscSplattedResource @Splatting).Invoke($params)
        } #end foreach
    } #end foreach
} #end configuration