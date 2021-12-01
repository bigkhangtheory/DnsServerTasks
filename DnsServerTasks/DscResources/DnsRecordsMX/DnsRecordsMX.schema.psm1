<#
    .SYNOPSIS
    The DnsRecordsNS DSC configuration manages MX DNS records against a specific zone on a Domain Name System (DNS) server.

    .DESCRIPTION
    The DnsRecordsNS DSC configuration manages MX DNS records against a specific zone on a Domain Name System (DNS) server.

    .PARAMETER DnsServer
    Specify the host name of the DNS server to create the MX DNS record. Defaults to 'localhost'.

    .PARAMETER ForwardLookupZones
    Specify a list of DNS Forward Lookup Zones to add MX DNS records.

    .PARAMETER ForwardLookupZones::ZoneName
    [System.String]

    .PARAMETER ForwardLookupZones::ZoneTTL
    [System.String]
    Specifies the TimeToLive value of all A records created in the zone. Value must be in valid TimeSpan string format. (Key Parameter)

    .PARAMETER ZoneName::Records
    [System.Collections.Hashtable[]]
    Specify a list of MX DNS records to create.

    .PARAMETER Records::EmailDomain
    [System.String]
    Everything after the '@' in the email addresses supported by this mail exchanger. It must be a subdomain the zone or the zone itself. To specify all subdomains, use the '' character (i.e.: .contoso.com).

    .PARAMETER Records::MailExchange
    [System.String]
    FQDN of the server handling email for the specified email domain. When setting the value, this FQDN must resolve to an IP address and cannot reference a CNAME record.

    .PARAMETER Records::Priority
    [System.UInt16]
    Specifies the priority for this MX record among other MX records that belong to the same email domain, where a lower value has a higher priority.

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
                        "Priority": 10,
                        "EmailDomain": "example.com",
                        "MailExchange": "smtp1.example.com"
                    },
                    {
                        "Priority": 100,
                        "EmailDomain": "*.example.com",
                        "MailExchange": "smtp2.example.com"
                    }
                ],
                "ZoneTTL": "01:00:00"
            },
            {
                "ZoneName": "bigkhangtheory.io",
                "Records": [
                    {
                        "Priority": 10,
                        "EmailDomain": "bigkhangtheory.io",
                        "MailExchange": "smtp1.bigkhangtheory.io"
                    },
                    {
                        "Priority": 100,
                        "EmailDomain": "*.bigkhangtheory.io",
                        "TimeToLive": "15.00:00:00",
                        "MailExchange": "smtp2.bigkhangtheory.io"
                    }
                ],
                "ZoneTTL": "1.00:00:00"
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
    Define and configure instances of DSC resources for MX DNS records

    .NOTES
    Author:     Khang M. Nguyen
    Company:    @bigkhangtheory
    Created:    2021-11

    .LINK
    https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordMx

    https://docs.microsoft.com/en-us/powershell/scripting/dsc/configurations/configdata?view=powershell-7.2
#>
#Requires -Module DnsServerDsc


configuration DnsRecordsMX
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

            # 'EmailDomain' must be specified, otherwise fail
            if (-not $record.ContainsKey('EmailDomain'))
            {
                throw 'ERROR: The EmailDomain property is not defined.'
            }
            else
            {
                $params.EmailDomain = $record.EmailDomain
            }

            # 'MailExchange' must be specified, otherwise fail
            if (-not $record.ContainsKey('MailExchange'))
            {
                throw 'ERROR: The MailExchange property is not defined.'
            }
            else
            {
                $params.MailExchange = $record.MailExchange
            }

            # 'MailExchange' must be specified, otherwise fail
            if (-not $record.ContainsKey('Priority'))
            {
                throw 'ERROR: The Priority property is not defined.'
            }
            else
            {
                $params.Priority = $record.Priority
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
            $executionName = "MX_$("$($params.ZoneName)_$($params.EmailDomain)_$($params.MailExchange)_$($params.Priority)_$($params.TimeToLive)_$($params.Ensure)" -replace '[()-.:\s]', '_')"

            $object = @"

    Creating DSC resource for DnsRecordMx with the following values:

        DnsRecordMx $($executionName)
        {
            ZoneName        = '$($params.ZoneName)'
            EmailDomain     = '$($params.EmailDomain)'
            MailExchange    = '$($params.MailExchange)'
            Priority        = $($params.Priority)
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
                ResourceName  = 'DnsRecordMx'
                ExecutionName = $executionName
                Properties    = $params
                NoInvoke      = $true
            }
            (Get-DscSplattedResource @Splatting).Invoke($params)
        } #end foreach
    } #end foreach
} #end configuration