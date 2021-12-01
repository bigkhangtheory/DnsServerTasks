<#
    .SYNOPSIS
        This DSC configuration manages the debugging and logging parameters on a Domain Name System (DNS) server.

    .DESCRIPTION
        The DnsServerDiagnosticSettings DSC configuration manages the debugging and logging parameters on a Domain Name System (DNS) server.

        If the parameter DnsServer is set to 'localhost' then the resource can normally use the default credentials (SYSTEM) to configure the DNS server
        settings. If using any other value for the parameter DnsServer make sure that the credential the resource is run as have the correct permissions
        at the target node and the necessary network traffic is permitted. It is possible to run the resource with specific credentials using the
        built-in parameter PsDscRunAsCredential.

    .PARAMETER DnsServer
        Key - [System.String]
        Specifies the DNS server to connect to, or use 'localhost' for the current node.

    .PARAMETER Answers
        Write - [System.Boolean]
        Specifies whether to enable the logging of DNS responses.

    .PARAMETER EnableLogFileRollover
        Write - [System.Boolean]
        Specifies whether to enable log file rollover.

    .PARAMETER EnableLoggingForLocalLookupEvent
        Write - [System.Boolean]
        Specifies whether the DNS server logs local lookup events.

    .PARAMETER EnableLoggingForPluginDllEvent
        Write - [System.Boolean]
        Specifies whether the DNS server logs dynamic link library (DLL) plug-in events.

    .PARAMETER EnableLoggingForRecursiveLookupEvent
        Write - [System.Boolean]
        Specifies whether the DNS server logs recursive lookup events.

    .PARAMETER EnableLoggingForRemoteServerEvent
        Write - [System.Boolean]
        Specifies whether the DNS server logs remote server events.

    .PARAMETER EnableLoggingForServerStartStopEvent
        Write - [System.Boolean]
        Specifies whether the DNS server logs server start and stop events.

    .PARAMETER EnableLoggingForTombstoneEvent
        Write - [System.Boolean]
        Specifies whether the DNS server logs tombstone events.

    .PARAMETER EnableLoggingForZoneDataWriteEvent
        Write - [System.Boolean]
        Specifies whether the DNS server logs zone data write events.

    .PARAMETER EnableLoggingForZoneLoadingEvent
        Write - [System.Boolean]
        Specifies whether the DNS server logs zone load events.

    .PARAMETER EnableLoggingToFile
        Write - [System.Boolean]
        Specifies whether the DNS server logs logging-to-file.

    .PARAMETER EventLogLevel
        Write - [System.UInt32]
        Specifies an event log level. Valid values are Warning, Error, and None.

    .PARAMETER FilterIPAddressList
        Write - [System.String[]]
        Specifies an array of IP addresses to filter. When you enable logging, traffic to and from these IP addresses is logged. If you do not specify any IP addresses, traffic to and from all IP addresses is logged.

    .PARAMETER FullPackets
        Write - [System.Boolean]
        Specifies whether the DNS server logs full packets.

    .PARAMETER LogFilePath
        Write - [System.String]
        Specifies a log file path.

    .PARAMETER MaxMBFileSize
        Write - [System.UInt32]
        Specifies the maximum size of the log file. This parameter is relevant if you set EnableLogFileRollover and EnableLoggingToFile to $true.

    .PARAMETER Notifications
        Write - [System.Boolean]
        Specifies whether the DNS server logs notifications.

    .PARAMETER Queries
        Write - [System.Boolean]
        Specifies whether the DNS server allows query packet exchanges to pass through the content filter, such as the FilterIPAddressList parameter.

    .PARAMETER QuestionTransactions
        Write - [System.Boolean]
        Specifies whether the DNS server logs queries.

    .PARAMETER ReceivePackets
        Write - [System.Boolean]
        Specifies whether the DNS server logs receive packets.

    .PARAMETER SaveLogsToPersistentStorage
        Write - [System.Boolean]
        Specifies whether the DNS server saves logs to persistent storage.

    .PARAMETER SendPackets
        Write - [System.Boolean]
        Specifies whether the DNS server logs send packets.

    .PARAMETER TcpPackets
        Write - [System.Boolean]
        Specifies whether the DNS server logs TCP packets.

    .PARAMETER UdpPackets
        Write - [System.Boolean]
        Specifies whether the DNS server logs UDP packets.

    .PARAMETER UnmatchedResponse
        Write - [System.Boolean]
        Specifies whether the DNS server logs unmatched responses.

    .PARAMETER Update
        Write - [System.Boolean]
        Specifies whether the DNS server logs updates.

    .PARAMETER UseSystemEventLog
        Write - [System.Boolean]
        Specifies whether the DNS server uses the system event log for logging.

    .PARAMETER WriteThrough
        Write - [System.Boolean]
        Specifies whether the DNS server logs write-throughs.

    .EXAMPLE
    {
        "LogFilePath": "C:\\Windows\\System32\\dns\\dnsdiag.log",
        "Notifications": true,
        "UdpPackets": false,
        "Answers": true,
        "EnableLoggingForPluginDllEvent": true,
        "QuestionTransactions": true,
        "UseSystemEventLog": true,
        "EnableLoggingForZoneLoadingEvent": true,
        "EnableLoggingForZoneDataWriteEvent": true,
        "ReceivePackets": false,
        "EnableLoggingForTombstoneEvent": true,
        "EnableLoggingForServerStartStopEvent": true,
        "EventLogLevel": 4,
        "Queries": true,
        "Update": true,
        "EnableLoggingForLocalLookupEvent": true,
        "EnableLogFileRollover": true,
        "SaveLogsToPersistentStorage": true,
        "EnableLoggingForRemoteServerEvent": true,
        "SendPackets": false,
        "TcpPackets": false,
        "FullPackets": false,
        "MaxMBFileSize": 500000000,
        "EnableLoggingForRecursiveLookupEvent": true,
        "EnableLoggingToFile": true,
        "WriteThrough": true,
        "UnmatchedResponse": false,
        "FilterIPAddressList": [
            "10.101.1.11",
            "10.101.1.12"
        ]
    }

    .INPUTS
        DSC Configuration Data

    .OUTPUTS
        DSC Managed Object Format (MOF) document

    .COMPONENT
        Desired State Configuration (DSC) Configurations

    .FUNCTIONALITY
        Define and configure instances of DSC resources for DNS Server diagnostics

    .NOTES
        Author:     Khang M. Nguyen
        Company:    @bigkhangtheory
        Created:    2021-11

    .LINK
        https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerDiagnostics

        https://docs.microsoft.com/en-us/powershell/scripting/dsc/configurations/configdata?view=powershell-7.2
#>
#Requires -Module DnsServerDsc


configuration DnsServerDiagnosticSettings
{
    param
    (
        [Parameter()]
        [System.String]
        $DnsServer,

        [Parameter()]
        [System.Boolean]
        $Answers,

        [Parameter()]
        [System.Boolean]
        $EnableLogFileRollover,

        [Parameter()]
        [System.Boolean]
        $EnableLoggingForLocalLookupEvent,

        [Parameter()]
        [System.Boolean]
        $EnableLoggingForPluginDllEvent,

        [Parameter()]
        [System.Boolean]
        $EnableLoggingForRecursiveLookupEvent,

        [Parameter()]
        [System.Boolean]
        $EnableLoggingForRemoteServerEvent,

        [Parameter()]
        [System.Boolean]
        $EnableLoggingForServerStartStopEvent,

        [Parameter()]
        [System.Boolean]
        $EnableLoggingForTombstoneEvent,

        [Parameter()]
        [System.Boolean]
        $EnableLoggingForZoneDataWriteEvent,

        [Parameter()]
        [System.Boolean]
        $EnableLoggingForZoneLoadingEvent,

        [Parameter()]
        [System.Boolean]
        $EnableLoggingToFile,

        [Parameter()]
        [System.UInt32]
        $EventLogLevel,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String[]]
        $FilterIPAddressList,

        [Parameter()]
        [System.Boolean]
        $FullPackets,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $LogFilePath,

        [Parameter()]
        [System.UInt32]
        $MaxMBFileSize,

        [Parameter()]
        [System.Boolean]
        $Notifications,

        [Parameter()]
        [System.Boolean]
        $Queries,

        [Parameter()]
        [System.Boolean]
        $QuestionTransactions,

        [Parameter()]
        [System.Boolean]
        $ReceivePackets,

        [Parameter()]
        [System.Boolean]
        $SaveLogsToPersistentStorage,

        [Parameter()]
        [System.Boolean]
        $SendPackets,

        [Parameter()]
        [System.Boolean]
        $TcpPackets,

        [Parameter()]
        [System.Boolean]
        $UdpPackets,

        [Parameter()]
        [System.Boolean]
        $UnmatchedResponse,

        [Parameter()]
        [System.Boolean]
        $Update,

        [Parameter()]
        [System.Boolean]
        $UseSystemEventLog,

        [Parameter()]
        [System.Boolean]
        $WriteThrough
    )

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName DnsServerDsc


    <#
        Declare resource parameters in array for comparison operations
    #>
    $dnsServerDiagnosticParameters = @(
        'DnsServer',
        'Answers',
        'EnableLogFileRollover',
        'EnableLoggingForLocalLookupEvent',
        'EnableLoggingForPluginDllEvent',
        'EnableLoggingForRecursiveLookupEvent',
        'EnableLoggingForRemoteServerEvent',
        'EnableLoggingForServerStartStopEvent',
        'EnableLoggingForTombstoneEvent',
        'EnableLoggingForZoneDataWriteEvent',
        'EnableLoggingForZoneLoadingEvent',
        'EnableLoggingToFile',
        'EventLogLevel',
        'FilterIPAddressList',
        'FullPackets',
        'LogFilePath',
        'MaxMBFileSize',
        'Notifications',
        'Queries',
        'QuestionTransactions',
        'ReceivePackets',
        'SaveLogsToPersistentStorage',
        'SendPackets',
        'TcpPackets',
        'UdpPackets',
        'UnmatchedResponse',
        'Update',
        'UseSystemEventLog',
        'WriteThrough'
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


    # if Answers is true, create the resource
    if ($Answers)
    {
        <#
            Match configuration data supplied for the resource
        #>
        $params = @{}

        foreach ($item in ($PSBoundParameters.GetEnumerator() | Where-Object Key -In $dnsServerDiagnosticParameters))
        {
            $params.Add($item.Key, $item.Value)
        }

        # set DNS server
        $params.DnsServer = $DnsServer

        # if 'EventLogLevel' not specified, set to 'Warning'
        if (-not $params.ContainsKey('EventLogLevel'))
        {
            $params.EventLogLevel = 4
        }

        # if DNS Server is the localhost, add resource dependency
        if ($dnsServerInstalled -eq $true)
        {
            #$dependsOn = $dependsOnRsatDnsServer
        }

        # set resource dependencies
        $params.DependsOn = $dependsOn

        # create execution name for the resource
        $executionName = 'Diagnostics_Settings'

        $object = @"

        Creating DSC resource for DnsServerDiagnostics with the following values:

        DnsServerDiagnostics "$executionName"
        {
            DnsServer                            = $($params.DnsServer)
            Answers                              = $($params.Answers)
            DependsOn                            = $($params.DependsOn)
            EnableLogFileRollover                = $($params.EnableLogFileRollover)
            EnableLoggingForLocalLookupEvent     = $($params.EnableLoggingForLocalLookupEvent)
            EnableLoggingForPluginDllEvent       = $($params.EnableLoggingForPluginDllEvent)
            EnableLoggingForRecursiveLookupEvent = $($params.EnableLoggingForRecursiveLookupEvent)
            EnableLoggingForRemoteServerEvent    = $($params.EnableLoggingForRemoteServerEvent)
            EnableLoggingForServerStartStopEvent = $($params.EnableLoggingForServerStartStopEvent)
            EnableLoggingForTombstoneEvent       = $($params.EnableLoggingForTombstoneEvent)
            EnableLoggingForZoneDataWriteEvent   = $($params.EnableLoggingForZoneDataWriteEvent)
            EnableLoggingForZoneLoadingEvent     = $($params.EnableLoggingForZoneLoadingEvent)
            EnableLoggingToFile                  = $($params.EnableLoggingToFile)
            EventLogLevel                        = $($params.EventLogLevel)
            FilterIPAddressList                  = $($params.FilterIPAddressList)
            FullPackets                          = $($params.FullPackets)
            LogFilePath                          = $($params.LogFilePath)
            MaxMBFileSize                        = $($params.MaxMBFileSize)
            Notifications                        = $($params.Notifications)
            Queries                              = $($params.Queries)
            QuestionTransactions                 = $($params.QuestionTransactions)
            ReceivePackets                       = $($params.ReceivePackets)
            SaveLogsToPersistentStorage          = $($params.SaveLogsToPersistentStorage)
            SendPackets                          = $($params.SendPackets)
            TcpPackets                           = $($params.TcpPackets)
            UdpPackets                           = $($params.UdpPackets)
            UnmatchedResponse                    = $($params.UnmatchedResponse)
            Update                               = $($params.Update)
            UseSystemEventLog                    = $($params.UseSystemEventLog)
            WriteThrough                         = $($params.WriteThrough)
        }
"@

        Write-Host "$object" -ForegroundColor Yellow

        # create DSC resource for DNS Server diagnostics
        $Splatting = @{
            ResourceName  = 'DnsServerDiagnostics'
            ExecutionName = $executionName
            Properties    = $params
            NoInvoke      = $true
        }
        (Get-DscSplattedResource @Splatting).Invoke($params)
    } #end if
} #end configuration