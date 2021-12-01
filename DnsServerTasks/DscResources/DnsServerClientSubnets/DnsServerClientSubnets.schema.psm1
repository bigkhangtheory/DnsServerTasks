<#
    .SYNOPSIS
        The DnsServerClientSubnet DSC resource manages DNS Client Subnets on a Domain Name System (DNS) server.

    .DESCRIPTION
        The DnsServerClientSubnet DSC resource manages DNS Client Subnets on a Domain Name System (DNS) server. A client subnet is a group of IP subnets that represent a logical group, for example, a geographical area, a datacenter, or a trusted resolver fleet. You can use client subnets in criteria in DNS policies. Multiple DNS policies can refer to the same client subnet.

    .PARAMETER ClientSubnets
        [System.Collections.Hashtable[]]
        Specify a list of DNS Client Subnets.

    .PARAMETER ClientSubnets::Name
        Key - [System.String]
        Specifies the name of the client subnet.

    .PARAMETER ClientSubnets::IPv4Subnet
        Write - [System.String[]]
        Specify an array (1 or more values) of IPv4 Subnet addresses in CIDR Notation.

    .PARAMETER ClientSubnets::IPv6Subnet
        Write - [System.String[]]
        Specify an array (1 or more values) of IPv6 Subnet addresses in CIDR Notation.

    .PARAMETER ClientSubnets::Ensure
        Write - [System.String]
        Allowed values: Present, Absent
        Should this DNS server client subnet be present or absent

    .EXAMPLE
    {
        "Subnets": [
            {
                "Ipv4Subnet": [
                    "10.200.16.0/24",
                    "10.200.17.0/24",
                    "10.200.18.0/23",
                    "10.200.20.0/24",
                    "10.200.21.0/24",
                    "10.200.22.0/24",
                    "10.200.23.0/24"
                ],
                "Ensure": "Present",
                "Name": "SITE-1"
            },
            {
                "Ipv4Subnet": [
                    "10.200.32.0/24",
                    "10.200.33.0/24",
                    "10.200.34.0/23",
                    "10.200.36.0/24",
                    "10.200.37.0/24",
                    "10.200.38.0/24",
                    "10.200.39.0/24"
                ],
                "Ensure": "Present",
                "Name": "SITE-2"
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
        Requirements

        Target machine must be running Windows Server 2016 or later.

    .NOTES
        Author:     Khang M. Nguyen
        Company:    @bigkhangtheory
        Created:    2021-11

    .LINK
        https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerClientSubnet

        https://docs.microsoft.com/en-us/powershell/scripting/dsc/configurations/configdata?view=powershell-7.2

#>
#Requires -Module DnsServerDsc


configuration DnsServerClientSubnets
{
    param
    (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Hashtable[]]
        $ClientSubnets
    )

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName DnsServerDsc


    <#
        Enumerate configuration data
    #>
    foreach ($clientSubnet in $ClientSubnets)
    {
        # remove sensitivity of ordered Dictionary or Hashtables
        $clientSubnet = @{ } + $clientSubnet

        # the property 'IPv4Subnet' and/or 'IPv6Subnet' must be specified for the subnet
        if ( (-not $clientSubnet.ContainsKey('IPv4Subnet')) -and (-not $clientSubnet.ContainsKey('IPv6Subnet')) )
        {
            throw 'ERROR: The property IPv4Subnet and/or IPv6Subnet cannot be found.'
        }

        # if not specified, ensure 'Present'
        if (-not $clientSubnet.ContainsKey('Ensure'))
        {
            $clientSubnet.Ensure = 'Present'
        }

        # create execution name for the resource
        $executionName = "Subnet_$("$($clientSubnet.Name)_$($clientSubnet.Ensure)" -replace '[()-.:\s]', '_')"


        # create DSC resource
        $Splatting = @{
            ResourceName  = 'DnsServerClientSubnet'
            ExecutionName = $executionName
            Properties    = $clientSubnet
            NoInvoke      = $true
        }
        (Get-DscSplattedResource @Splatting).Invoke($clientSubnet)
    } #end foreach
} #end configuration