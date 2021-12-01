<#
    .SYNOPSIS
    The DnsRecordsNS DSC configuration manages SRV DNS records against a specific zone on a Domain Name System (DNS) server.

    .DESCRIPTION
    The DnsRecordsNS DSC configuration manages SRV DNS records against a specific zone on a Domain Name System (DNS) server.

    .PARAMETER DnsServer
    Specify the host name of the DNS server to create the SRV DNS record. Defaults to 'localhost'.

    .PARAMETER ForwardLookupZones
    Specify a list of DNS Forward Lookup Zones to add SRV DNS records.

    .PARAMETER ForwardLookupZones::ZoneName
    [System.String]
    Specifies the name of a DNS zone. (Key Parameter)

    .PARAMETER ForwardLookupZones::ZoneTTL
    [System.String]
    Specifies the TimeToLive value of all A records created in the zone. Value must be in valid TimeSpan string format. (Key Parameter)

    .PARAMETER ZoneName::Records
    [System.Collections.Hashtable[]]
    Specify a list of SRV DNS records to create.

    .PARAMETER Records::SymbolicName
    [System.String]
    Service name for the SRV record. eg: xmpp, ldap, etc. (Key Parameter)

    .PARAMETER Records::Protocol
    [System.String]
    Service transmission protocol ('TCP' or 'UDP') (Key Parameter)

    .PARAMETER Records::Port
    [System.UInt16]
    The TCP or UDP port on which the service is found (Key Parameter)

    .PARAMETER Records::Target
    [System.String]
    Specifies the Target Hostname or IP Address. (Key Parameter)

    .PARAMETER Records::Priority
    [System.UInt16]
    Specifies the Priority value of the SRV record. (Mandatory Parameter)

    .PARAMETER Records::Weight
    [System.UInt16]
    Specifies the weight of the SRV record. (Mandatory Parameter)

    .PARAMETER Records::Ensure
    [System.String]
    Accepted Values: 'Present', 'Absent'
    Whether the host record should be present or removed. (Optional Paraemeter)

    .EXAMPLE
    {
        "ForwardLookupZones": [
            {
                "ZoneName": "example.com",
                "Records": [
                    {
                        "Weight": 100,
                        "Port": 3268,
                        "SymbolicName": "_gc",
                        "Target": "ns1.example.com",
                        "Priority": 0,
                        "Protocol": "tcp"
                    },
                    {
                        "Weight": 100,
                        "Port": 88,
                        "SymbolicName": "_kerberos",
                        "Target": "ns1.example.com",
                        "Priority": 0,
                        "Protocol": "tcp"
                    },
                    {
                        "Weight": 100,
                        "Port": 88,
                        "SymbolicName": "_kerberos",
                        "Target": "ns1.example.com",
                        "Priority": 0,
                        "Protocol": "udp"
                    },
                    {
                        "Weight": 100,
                        "Port": 464,
                        "SymbolicName": "_kpasswd",
                        "Target": "ns1.example.com",
                        "Priority": 0,
                        "Protocol": "tcp"
                    },
                    {
                        "Weight": 100,
                        "Port": 464,
                        "SymbolicName": "_kpasswd",
                        "Target": "ns1.example.com",
                        "Priority": 0,
                        "Protocol": "udp"
                    },
                    {
                        "Weight": 100,
                        "Port": 389,
                        "SymbolicName": "_ldap",
                        "Target": "ns1.example.com",
                        "Priority": 0,
                        "Protocol": "tcp"
                    },
                    {
                        "Weight": 100,
                        "Port": 636,
                        "SymbolicName": "ldaps",
                        "Target": "ns1.example.com",
                        "Priority": 0,
                        "Protocol": "tcp"
                    }
                ],
                "ZoneTTL": "00:05:00"
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
    Define and configure instances of DSC resources for SRV DNS records

    .NOTES
    Author:     Khang M. Nguyen
    Company:    @bigkhangtheory
    Created:    2021-11

    .LINK
    https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordA

    https://docs.microsoft.com/en-us/powershell/scripting/dsc/configurations/configdata?view=powershell-7.2
#>
#Requires -Module DnsServerDsc


configuration DnsRecordsSRV
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

            # if 'SymbolicName' specified, assign the value, otherwise fail
            if (-not $record.ContainsKey('SymbolicName'))
            {
                throw 'ERROR: The SymbolicName property is not defined.'
            }
            else
            {
                $params.SymbolicName = $record.SymbolicName
            }

            # if 'Protocol' specified, assign the value, otherwise fail
            if (-not $record.ContainsKey('Protocol'))
            {
                throw 'ERROR: The Protocol property is not defined.'
            }
            else
            {
                $params.Protocol = $record.Protocol
            }

            # if 'Port' specified, assign the value, otherwise fail
            if (-not $record.ContainsKey('Port'))
            {
                throw 'ERROR: The Port property is not defined.'
            }
            else
            {
                $params.Port = $record.Port
            }

            # if 'Target' specified, assign the value, otherwise fail
            if (-not $record.ContainsKey('Target'))
            {
                throw 'ERROR: The Target property is not defined.'
            }
            else
            {
                $params.Target = $record.Target
            }

            # if 'Priority' specified, assign the value, otherwise fail
            if (-not $record.ContainsKey('Priority'))
            {
                throw 'ERROR: The Priority property is not defined.'
            }
            else
            {
                $params.Priority = $record.Priority
            }

            # if 'Weight' specified, assign the value, otherwise fail
            if (-not $record.ContainsKey('Weight'))
            {
                throw 'ERROR: The Weight property is not defined.'
            }
            else
            {
                $params.Weight = $record.Weight
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

            # if 'TimeToLive' not specified, set default to 5 minutes
            if (-not $params.ContainsKey('TimeToLive'))
            {
                $params.TimeToLive = '00:05:00'
            }

            # if not specified, ensure 'Present'
            if (-not $record.ContainsKey('Ensure'))
            {
                $params.Ensure = 'Present'
            }


            # create execution name for the resource
            $executionName = "A_$("$($params.ZoneName)_$($params.SymbolicName)_$($params.Protocol)_$($params.Port)_$($params.Target)_$($params.Ensure)" -replace '[()-.:\s]', '_')"

            $object = @"

    Creating DSC resource for DnsRecordSrv with the following values:

        DnsRecordSrv $($executionName)
        {
            ZoneName     = '$($params.ZoneName)'
            SymbolicName = '$($params.SymbolicName)'
            Protocol     = '$($params.Protocol)'
            Port         = $($params.Port)
            Target       = '$($params.Target)'
            Priority     = $($params.Priority)
            Weight       = $($params.Weight)
            TimeToLive   = '$($params.TimeToLive)'
            Ensure       = '$($params.Ensure)'
        }

"@
            Write-Host "$object" -ForegroundColor Yellow

            <#
                Create DSC resource for NS DNS record
            #>
            $Splatting = @{
                ResourceName  = 'DnsRecordSrv'
                ExecutionName = $executionName
                Properties    = $params
                NoInvoke      = $true
            }
            (Get-DscSplattedResource @Splatting).Invoke($params)
        } #end foreach
    } #end foreach
} #end configuration