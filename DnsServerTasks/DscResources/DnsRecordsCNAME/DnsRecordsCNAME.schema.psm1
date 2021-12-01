<#
    .SYNOPSIS
    The DnsRecordsNS DSC configuration manages CNAME DNS records against a specific zone on a Domain Name System (DNS) server.

    .DESCRIPTION
    The DnsRecordsNS DSC configuration manages CNAME DNS records against a specific zone on a Domain Name System (DNS) server.

    .PARAMETER DnsServer
    Specify the host name of the DNS server to create the CNAME DNS record. Defaults to 'localhost'.

    .PARAMETER ForwardLookupZones
    Specify a list of DNS Forward Lookup Zones to add CNAME DNS records.

    .PARAMETER ForwardLookupZones::ZoneName
    [System.String]
    Specifies the name of a DNS zone. (Key Parameter)

    .PARAMETER ForwardLookupZones::ZoneTTL
    [System.String]
    Specifies the TimeToLive value of all A records created in the zone. Value must be in valid TimeSpan string format. (Key Parameter)

    .PARAMETER ZoneName::Records
    [System.Collections.Hashtable[]]
    Specify a list of CNAME DNS records to create.

    .PARAMETER Records::Name
    [System.String]
    Specifies the name of a DNS server resource record object. (Key Parameter)

    .PARAMETER Records::HostAlias
    [System.String]
    Specifies a a canonical name target for a CNAME record. This must be a fully qualified domain name (FQDN). (Key Parameter)

    .PARAMETER Records::Ensure
    [System.String]
    Accepted Values: 'Present', 'Absent'
    Whether the host record should be present or removed. (Optional Paraemeter)

    .EXAMPLE
    {
        "DnsServer": "ns1.example.com",
        "ForwardLookupZones": [
            {
                "ZoneName": "example.com",
                "Records": [
                    {
                        "HostAlias": "server1.example.com",
                        "Name": "alias1"
                    },
                    {
                        "HostAlias": "server2.example.com",
                        "Name": "alias2"
                    }
                ],
                "ZoneTTL": "01:00:00"
            },
            {
                "ZoneName": "bigkhangtheory.io",
                "Records": [
                    {
                        "HostAlias": "server3.bigkhangtheory.io",
                        "TimeToLive": "00:05:00",
                        "Name": "alias3"
                    },
                    {
                        "HostAlias": "server4.bigkhangtheory.io",
                        "Name": "alias4"
                    }
                ],
                "ZoneTTL": "00:20:00"
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
    Define and configure instances of DSC resources for CNAME DNS records

    .NOTES
    Author:     Khang M. Nguyen
    Company:    @bigkhangtheory
    Created:    2021-11

    .LINK
    https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordA

    https://docs.microsoft.com/en-us/powershell/scripting/dsc/configurations/configdata?view=powershell-7.2
#>
#Requires -Module DnsServerDsc
#Requires -Module DnsServerDsc


configuration DnsRecordsCNAME
{
    param
    (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
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

            # if 'Name' specified, assign the value, otherwise fail
            if (-not $record.ContainsKey('Name'))
            {
                throw 'ERROR: The Name property is not defined.'
            }
            else
            {
                $params.Name = $record.Name
            }

            ## 'IPv4Address' must be specified
            if (-not $record.ContainsKey('HostAlias'))
            {
                throw 'ERROR: The HostAlias property is not defined.'
            }
            else
            {
                $params.HostNameAlias = $record.HostAlias
            }

            # if DefaultTimeToLive is specified and TimeToLive is not, set TimeToLive for the resource
            if ( $record.ContainsKey('TimeToLive') )
            {
                # validate TimeSpan formatting
                if (($record.TimeToLive -as [System.TimeSpan] -eq $null))
                {
                    throw "ERROR: TimeToLive value $($record.TimeToLive) is not a valid [System.TimeSpan] format"
                }
                else
                {
                    $params.TimeToLive = $record.TimeToLive
                }
            }

            # if 'TimeToLive' not specified, set default to 1 hour
            if (-not $params.ContainsKey('TimeToLive'))
            {
                $params.TimeToLive = '01:00:00'
            }

            # if not specified, ensure 'Present'
            if (-not $record.ContainsKey('Ensure'))
            {
                $params.Ensure = 'Present'
            }

            # create execution name for the resource
            $executionName = "A_$("$($params.ZoneName)_$($params.Name)_$($params.HostNameAlias)_$($params.TimeToLive)$($params.Ensure)" -replace '[()-.:\s]', '_')"

            $object = @"

    Creating DSC resource for DnsRecordCname with the following values:

        DnsRecordCname $($executionName)
        {
            ZoneName        = '$($params.ZoneName)'
            Name            = '$($params.Name)'
            HostNameAlias   = '$($params.HostNameAlias)'
            TimeToLive      = '$($params.TimeToLive)'
            DnsServer       = '$($params.DnsServer)'
            Ensure          = '$($params.Ensure)'
        }

"@
            Write-Host "$object" -ForegroundColor Yellow

            <#
                Create DSC resource for NS DNS record
            #>
            $Splatting = @{
                ResourceName  = 'DnsRecordCname'
                ExecutionName = $executionName
                Properties    = $params
                NoInvoke      = $true
            }
            (Get-DscSplattedResource @Splatting).Invoke($params)
        } #end foreach
    } #end foreach
} #end configuration