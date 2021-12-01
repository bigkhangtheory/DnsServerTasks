<#
    .SYNOPSIS
    The DnsRecordsNS DSC configuration manages NS DNS records against a specific zone on a Domain Name System (DNS) server.

    .DESCRIPTION
    The DnsRecordsNS DSC configuration manages NS DNS records against a specific zone on a Domain Name System (DNS) server.

    .PARAMETER DnsServer
    Specify the host name of the DNS server to create the NS DNS record. Defaults to 'localhost'.

    .PARAMETER ForwardLookupZones
    Specify a list of DNS Forward Lookup Zones to add NS DNS records.

    .PARAMETER ForwardLookupZones::ZoneName
    [System.String]
    Specifies the name of a DNS zone. (Key Parameter)

    .PARAMETER ForwardLookupZones::ZoneTTL
    [System.String]
    Specifies the TimeToLive value of all A records created in the zone. Value must be in valid TimeSpan string format. (Key Parameter)

    .PARAMETER ZoneName::Records
    [System.Collections.Hashtable[]]
    Specify a list of NS DNS records to create.

    .PARAMETER Records::DomainName
    [System.String]
    Specifies the fully qualified DNS domain name for which the NameServer is authoritative. It must be a subdomain the zone or the zone itself. To specify all subdomains, use the '' character (i.e.: .contoso.com). (Key Parameter)

    .PARAMETER Records::NameServers
    [System.Collections.Hashtable[]]
    Specifies a list of name servers to be authorative for the domain. This should be a fully qualified domain name, not an IP address (Key Parameter)

    .EXAMPLE
    {
        "ForwardLookupZones": [
            {
                "ZoneName": "example.com",
                "Records": [
                    {
                        "NameServers": [
                            "ns1.example.com",
                            "ns2.example.com"
                        ],
                        "DomainName": "example.com"
                    },
                    {
                        "DomainName": "*.example.com",
                        "TimeToLive": "00:30:00",
                        "NameServers": [
                            "ns1.example.com",
                            "ns2.example.com"
                        ]
                    }
                ],
                "ZoneTTL": "01:00:00"
            },
            {
                "ZoneName": "bigkhangtheory.io",
                "Records": [
                    {
                        "NameServers": [
                            "ns1.example.com",
                            "ns2.example.com"
                        ],
                        "DomainName": "bigkhangtheory.io"
                    }
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
    Define and configure instances of DSC resources for NS DNS records

    .NOTES
    Author:     Khang M. Nguyen
    Company:    @bigkhangtheory
    Created:    2021-11

    .LINK
    https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordNs

    https://docs.microsoft.com/en-us/powershell/scripting/dsc/configurations/configdata?view=powershell-7.2
#>
#Requires -Module DnsServerDsc


configuration DnsRecordsNS
{
    param
    (
        [Parameter()]
        [System.String]
        $DnsServer,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Hashtable[]]
        $ForwardLookupZones
    )

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName DnsServerDsc


    # boolean flag to track installation of DNS server
    [boolean]$dnsServerInstalled = $false


    # if 'DnsServer' is not specified, default to 'localhost'
    if (-not $PSBoundParameters.ContainsKey('DnsServer'))
    {
        $DnsServer = 'localhost'
    }

    # install DNS server if DNS record shall be set on a local DNS server
    if ($DnsServer -eq 'localhost')
    {
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

        # flag DNS server installation is true
        $dnsServerInstalled = $true
    } #end if



    # enumerate a list of zones
    foreach ($zone in $ForwardLookupZones)
    {
        # create a hashtable object to store parameters
        $params = New-Object -TypeName System.Collections.Hashtable

        # set DnsServer value
        $params.DnsServer = $DnsServer

        # if DnsServer is localhost, this resource depends on instalaltion of DNS Server
        if ($dnsServerInstalled -eq $true)
        {
            $params.DependsOn = $dependsOnRsatDnsServer
        }

        # remove case sensitivity of ordered Dictionary or Hashtables
        $zone = @{ } + $zone

        # if 'ZoneName' specified, assign the value, otherwise fail
        if (-not $zone.ContainsKey('ZoneName'))
        {
            throw 'ERROR: The ZoneName property cannot be found.'
        }
        else
        {
            $params.ZoneName = $zone.ZoneName
        }

        # if 'ZoneTTL' is specified, validate TimeSpan formatting
        if ($zone.ContainsKey('ZoneTTL'))
        {
            if (($zone.ZoneTTL -as [System.TimeSpan] -eq $null))
            {
                throw "ERROR: Zone TTL value $($zone.ZoneTTL) is not a valid [System.TimeSpan] format"
            }
            else
            {
                # assign the TimeToLive value
                $params.TimeToLive = $zone.ZoneTTL
            }
        }

        # this resource must contain a list of records
        if (-not $zone.ContainsKey('Records'))
        {
            throw 'ERROR: Specifying a zone requires a list of records.'
        }

        # enumerate a list of records
        foreach ($record in $zone.Records)
        {
            # Remove Case Sensitivity of ordered Dictionary or Hashtables
            $record = @{} + $record

            # if 'DomainName' specified, assign the value, otherwise fail
            if (-not $record.ContainsKey('DomainName'))
            {
                throw 'ERROR: The DomainName property cannot be found.'
            }
            else
            {
                $params.DomainName = $record.DomainName
            }

            # if DefaultTimeToLive is specified and TimeToLive is not, set TimeToLive for the resource
            if ( $record.ContainsKey('TimeToLive') )
            {
                # validate TimeSpan formatting
                if (($record.TimeToLive -as [System.TimeSpan] -eq $null))
                {
                    throw "ERROR: Zone TTL value $($record.TimeToLive) is not a valid [System.TimeSpan] format"
                }
                else
                {
                    $params.TimeToLive = $record.TimeToLive
                }
            }

            # this resource must contain a list of records
            if (-not $record.ContainsKey('NameServers'))
            {
                throw 'ERROR: Specifying a DomainName requires a list of name servers.'
            }

            # enumerate a list of name servers
            foreach ($nameServer in $record.NameServers)
            {
                # set the Name Server
                $params.NameServer = $nameServer

                # if 'TimeToLive' not specified, set default to 1 hour
                if (-not $params.ContainsKey('TimeToLive'))
                {
                    $params.TimeToLive = '01:00:00'
                }

                # ensure the resource is 'Present'
                $params.Ensure = 'Present'

                # create execution name for the resource
                $executionName = "NS_$("$($params.ZoneName)_$($params.DomainName)_$($params.NameServer)_$($params.TimeToLive)" -replace '[()-.:\s]', '_')"

                $object = @"

    Creating DSC resource for DnsRecordNS with the following values:

        DnsRecordNS $($executionName)
        {
            ZoneName        = $($params.ZoneName)
            DomainName      = $($params.DomainName)
            NameServer      = $($params.NameServer)
            TimeToLive      = $($params.TimeToLive)
            DnsServer       = $($params.DnsServer)
            Ensure          = $($params.Ensure)
        }

"@
                Write-Host "$object" -ForegroundColor Yellow

                <#
                    Create DSC resource for NS DNS record
                #>
                $Splatting = @{
                    ResourceName  = 'DnsRecordNS'
                    ExecutionName = $executionName
                    Properties    = $params
                    NoInvoke      = $true
                }
                (Get-DscSplattedResource @Splatting).Invoke($params)
            } #end foreach
        } #end foreach
    } #end foreach
} #end configuration