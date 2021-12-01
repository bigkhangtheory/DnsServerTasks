<#
    .SYNOPSIS
        The DnsServerConditionalForwarders DSC configuration manages a conditional forwarder on a Domain Name System (DNS) server.

    .DESCRIPTION
        The DnsServerConditionalForwarders DSC configuration manages a conditional forwarder on a Domain Name System (DNS) server.

        You can manage the master servers, forwarder time-out, recursion, recursion scope, and directory partition name for a conditional forwarder zone.

    .PARAMETER ConditionalForwarders
        Mandatory - [System.Collections.Hashtable[]]
        Specifies a list of DNS conditional forwarders

    .PARAMETER ConditionalForwarders::Name
        Key - [System.String]
        The name of the zone to manage.

    .PARAMETER ConditionalForwarders::MasterServers
        Write - [System.String[]]
        The IP addresses the forwarder should use. Mandatory if Ensure is present.

    .PARAMETER ConditionalForwarders::ReplicationScope
        Write - [System.String]
        Allowed values: None, Custom, Domain, Forest, Legacy
        Whether the conditional forwarder should be replicated in AD, and the scope of that replication. Default is None.

    .PARAMETER ConditionalForwarders::DirectoryPartitionName
        Write - [System.String]
        The name of the directory partition to use when the ReplicationScope is Custom. This value is ignored for all other replication scopes.

    .PARAMETER ConditionalForwarders::Ensure
        Write - [System.String]
        Allowed values: Present, Absent
        Ensure whether the zone is absent or present.

    .EXAMPLE
        {
            "ConditionalForwarders": [
                {
                    "Name": "SharedServices",
                    "MasterServers": [
                        "10.0.1.10",
                        "10.0.2.10"
                    ],
                    "ReplicationScope": "Forest"
                },
                {
                    "Name": "Oxy",
                    "MasterServers": [
                        "10.0.3.10"
                    ],
                    "ReplicationScope": "Forest"
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
        Define and configure instances of DSC resources for DNS conditional forwarders

    .NOTES
        Author:     Khang M. Nguyen
        Company:    @bigkhangtheory
        Created:    2021-11

    .LINK
        https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerConditionalForwarder

        https://docs.microsoft.com/en-us/powershell/scripting/dsc/configurations/configdata?view=powershell-7.2
#>
#Requires -Module DnsServerDsc


configuration DnsServerConditionalForwarders
{
    param
    (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Hashtable[]]
        $ConditionalForwarders
    )

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName DnsServerDsc


    <#
        Create DSC resource for installation of Windows Role DNS Server
    #>
    WindowsFeature AddDns
    {
        Name   = 'DNS'
        Ensure = 'Present'
    }
    <#
        Create DSC resource for installation of Windows Feature RSAT DNS Server
    #>
    WindowsFeature AddRsatDnsServer
    {
        Name      = 'RSAT-DNS-Server'
        Ensure    = 'Present'
        DependsOn = '[WindowsFeature]AddDns'
    }
    # set dependency reference
    $dependsOnRsatDnsServer = '[WindowsFeature]AddRsatDnsServer'


    <#
        Enumerate conditional forwarders
    #>
    foreach ($conditionalForwarder in $ConditionalForwarders)
    {
        # remove case sensitivity of ordered Dictionary or Hashtables
        $conditionalForwarder = @{ } + $conditionalForwarder

        # if 'ReplicationScope' is not specified, default to 'None'
        if (-not $conditionalForwarder.ContainsKey('ReplicationScope'))
        {
            $conditionalForwarder.ReplicationScope = 'None'
        }

        # if not specified, ensure 'Present'
        if (-not $conditionalForwarder.ContainsKey('Ensure'))
        {
            $conditionalForwarder.Ensure = 'Present'
        }

        # this resource depends on installation of DNS server
        $conditionalForwarder.DependsOn = $dependsOnRsatDnsServer

        # create execution name for the resource
        $executionName = "$("$($node.Name)_$($conditionalForwarder.Name)" -replace '[-().:\s]', '_')"

        # create DSC resource
        $Splatting = @{
            ResourceName  = 'DnsServerConditionalForwarder'
            ExecutionName = $executionName
            Properties    = $conditionalForwarder
            NoInvoke      = $true
        }
        (Get-DscSplattedResource @Splatting).Invoke($conditionalForwarder)
    } #end foreach
} #end configuration
