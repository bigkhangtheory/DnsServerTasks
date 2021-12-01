<#
    .SYNOPSIS
        The DnsServerDsSetting DSC resource manages DNS Active Directory settings on a Microsoft Domain Name System (DNS) server.

    .DESCRIPTION
        The DnsServerDsSetting DSC resource manages DNS Active Directory settings on a Microsoft Domain Name System (DNS) server.

    .PARAMETER DnsServer
        Key - System.String
        The host name of the Domain Name System (DNS) server, or use 'localhost' for the current node.

    .PARAMETER DirectoryPartitionAutoEnlistInterval
        Write - System.String

        Specifies the interval, during which a DNS server tries to enlist itself
        in a DNS domain partition and DNS forest partition, if it is not already
        enlisted. We recommend that you limit this value to the range one hour to
        180 days, inclusive, but you can use any value. We recommend that you set
        the default value to one day. You must set the value 0 (zero) as a flag
        value for the default value. However, you can allow zero and treat it
        literally.

    .PARAMETER LazyUpdateInterval
        Write - Nullable[System.UInt32]

        Specifies a value, in seconds, to determine how frequently the DNS server submits updates to the directory server without specifying the
        LDAPSERVERLAZYCOMMITOID control ([MS-ADTS] section 3.1.1.3.4.1.7) at the same time that it processes DNS dynamic update requests.

        We recommend that you limit this value to the range 0x00000000 to 0x0000003c.

        You must set the default value to 0x00000003.

        You must set the value zero to indicate that the DNS server does not specify the LDAPSERVERLAZYCOMMITOID control at the same time
        that it processes DNS dynamic update requests.

        For more information about LDAPSERVERLAZYCOMMITOID, see LDAPSERVERLAZYCOMMITOID control code.

        The LDAPSERVERLAZYCOMMITOID control instructs the DNS server to return the results of a directory service modification command after
        it is completed in memory but before it is committed to disk. In this way, the server can return results quickly and
        save data to disk without sacrificing performance.

        The DNS server must send this control only to the directory server that is attached to an LDAP update that the DNS server initiates
        in response to a DNS dynamic update request.

        If the value is nonzero, LDAP updates that occur during the processing of DNS dynamic update requests must not specify the LDAPSERVERLAZYCOMMITOID
        control if a period of less than DsLazyUpdateInterval seconds has passed since the last LDAP update that specifies this control.

        If a period that is greater than DsLazyUpdateInterval seconds passes, during which time the DNS server does not perform an LDAP update that specifies this
        control, the DNS server must specify this control on the next update.

    .PARAMETER MinimumBackgroundLoadThreads
        Write - [System.UInt32]

        Specifies the minimum number of background threads that the DNS server uses to load zone data from the directory service.

        You must limit this value to the range 0x00000000 to 0x00000005, inclusive.

        You must set the default value to 0x00000001, and you must treat the value zero as a flag value for the default value.

    .PARAMETER PollingInterval
        Write - System.String

        Specifies how frequently the DNS server polls Active Directory Domain Services (AD DS) for changes in Active Directory-integrated zones.

        You must limit the value to the range 30 seconds to 3,600 seconds, inclusive.

    .PARAMETER RemoteReplicationDelay
        Write - [System.UInt32]

        Specifies the minimum interval, in seconds, that the DNS server waits between the time that it determines that a single object has changed on
        a remote directory server, to the time that it tries to replicate a single object change.

        You must limit the value to the range 0x00000005 to 0x00000E10, inclusive.

        You must set the default value to 0x0000001E, and you must treat the value zero as a flag value for the default value.

    .PARAMETER TombstoneInterval
        Write - System.String

        Specifies the amount of time that DNS keeps tombstoned records alive in
        Active Directory. We recommend that you limit this value to the range
        three days to eight weeks, inclusive, but you can set it to any value in
        the range 82 hours to 8 weeks. We recommend that you set the default
        value to 14 days and treat the value zero as a flag value for the
        default. However, you can allow the value zero and treat it literally.
        At 2:00 A.M. local time every day, the DNS server must search all
        directory service zones for nodes that have the Active Directory
        dnsTombstoned attribute set to True, and for a directory service
        EntombedTime (section 2.2.2.2.3.23 of MS-DNSP) value that is greater
        than previous directory service DSTombstoneInterval seconds. You must
        permanently delete all such nodes from the directory server.

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
        Define and configure instances of DSC resources for DNS Directory Services configuration

    .NOTES
        Requirements

        Target machine must be running Windows Server 2016 or later.

    .NOTES
        Author:     Khang M. Nguyen
        Company:    @bigkhangtheory
        Created:    2021-11

    .LINK
        https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerDsSetting

        https://docs.microsoft.com/en-us/powershell/scripting/dsc/configurations/configdata?view=powershell-7.2
#>
#Requires -Module DnsServerDsc


configuration ActiveDirectoryDnsSettings
{
    param
    (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $DnsServer,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $DirectoryPartitionAutoEnlistInterval,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.UInt32]
        $LazyUpdateInterval,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.UInt32]
        $MinimumBackgroundLoadThreads,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $PollingInterval,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.UInt32]
        $RemoteReplicationDelay,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $TombstoneInterval
    )

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName DnsServerDsc


    <#
        Declare resource parameters in array for comparison operations
    #>
    $dnsServerDsSettingsParams = @(
        'DnsServer',
        'DirectoryPartitionAutoEnlistInterval',
        'LazyUpdateInterval',
        'MinimumBackgroundLoadThreads',
        'PollingInterval',
        'RemoteReplicationDelay',
        'TombstoneInterval'
    )


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


    <#
        Match configuration data supplied for the resource
    #>
    $params = @{}

    foreach ($item in ($PSBoundParameters.GetEnumerator() | Where-Object Key -In $dnsServerDsSettingsParams))
    {
        $params.Add($item.Key, $item.Value)
    }

    # set DNS server
    $params.DnsServer = $DnsServer

    # if 'DirectoryPartitionAutoEnlistInterval' not specified, set to 1 day
    if (-not $params.ContainsKey('DirectoryPartitionAutoEnlistInterval'))
    {
        $params.DirectoryPartitionAutoEnlistInterval = '1'
    }

    # if 'LazyUpdateInterval' not specified, set default to '3' seconds
    if (-not $params.ContainsKey('LazyUpdateInterval'))
    {
        $params.LazyUpdateInterval = 3
    }

    # if 'MinimumBackgroundLoadThreads' not specified, set default to '1' thread
    if (-not $params.ContainsKey('MinimumBackgroundLoadThreads'))
    {
        $params.MinimumBackgroundLoadThreads = 1
    }

    # if 'PollingInterval' not specified, set default to '180' seconds
    if (-not $params.ContainsKey('PollingInterval'))
    {
        $params.PollingInterval = '180'
    }

    # if 'RemoteReplicationDelay' not specified, set default to '30' seconds
    if (-not $params.ContainsKey('RemoteReplicationDelay'))
    {
        $params.RemoteReplicationDelay = 30
    }

    # if 'TombstoneInterval' not specified, set default to '14' days
    if (-not $params.ContainsKey('TombstoneInterval'))
    {
        $params.TombstoneInterval = '14.00:00:00'
    }

    # if DNS Server is the localhost, add resource dependency
    if ($dnsServerInstalled -eq $true)
    {
        $params.DependsOn = $dependsOnRsatDnsServer
    }

    # create execution name for the resource
    $executionName = 'DS_Settings'


    # create DSC resource
    $Splatting = @{
        ResourceName  = 'DnsServerDsSetting'
        ExecutionName = $executionName
        Properties    = $params
        NoInvoke      = $true
    }
    (Get-DscSplattedResource @Splatting).Invoke($params)
} #end configuration