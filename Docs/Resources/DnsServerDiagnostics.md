# DnsServerDiagnostics

## Parameters

| Parameter                                | Attribute  | DataType          | Description                                                                                                                                                                                                      | Allowed Values |
| ---------------------------------------- | ---------- | ----------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| **DnsServer**                            | *Required* | `[String]`        | Specifies the DNS server to connect to, or use 'localhost' for the current node.                                                                                                                                 |                |
| **Answers**                              |            | `[Boolean]`       | Specifies whether to enable the logging of DNS responses.                                                                                                                                                        |                |
| **EnableLogFileRollover**                |            | `[Boolean]`       | Specifies whether to enable log file rollover.                                                                                                                                                                   |                |
| **EnableLoggingForLocalLookupEvent**     |            | `[Boolean]`       | Specifies whether the DNS server logs local lookup events.                                                                                                                                                       |                |
| **EnableLoggingForPluginDllEvent**       |            | `[Boolean]`       | Specifies whether the DNS server logs dynamic link library (DLL) plug-in events.                                                                                                                                 |                |
| **EnableLoggingForRecursiveLookupEvent** |            | `[Boolean]`       | Specifies whether the DNS server logs recursive lookup events.                                                                                                                                                   |                |
| **EnableLoggingForRemoteServerEvent**    |            | `[Boolean]`       | Specifies whether the DNS server logs remote server events.                                                                                                                                                      |                |
| **EnableLoggingForServerStartStopEvent** |            | `[Boolean]`       | Specifies whether the DNS server logs server start and stop events.                                                                                                                                              |                |
| **EnableLoggingForTombstoneEvent**       |            | `[Boolean]`       | Specifies whether the DNS server logs tombstone events.                                                                                                                                                          |                |
| **EnableLoggingForZoneDataWriteEvent**   |            | `[Boolean]`       | Specifies whether the DNS server logs zone data write events.                                                                                                                                                    |                |
| **EnableLoggingForZoneLoadingEvent**     |            | `[Boolean]`       | Specifies whether the DNS server logs zone load events.                                                                                                                                                          |                |
| **EnableLoggingToFile**                  |            | `[Boolean]`       | Specifies whether the DNS server logs logging-to-file.                                                                                                                                                           |                |
| **EventLogLevel**                        |            | `[System.UInt32]` | Specifies an event log level. Valid values are Warning, Error, and None.                                                                                                                                         |                |
| **FilterIPAddressList**                  |            | `[String[]]`      | Specifies an array of IP addresses to filter. When you enable logging, traffic to and from these IP addresses is logged. If you do not specify any IP addresses, traffic to and from all IP addresses is logged. |                |
| **FullPackets**                          |            | `[Boolean]`       | Specifies whether the DNS server logs full packets.                                                                                                                                                              |                |
| **LogFilePath**                          |            | `[String]`        | Specifies a log file path.                                                                                                                                                                                       |                |
| **MaxMBFileSize**                        |            | `[System.UInt32]` | Specifies the maximum size of the log file. This parameter is relevant if you set **EnableLogFileRollover** and **EnableLoggingToFile** to `$true`.                                                              |                |
| **Notifications**                        |            | `[Boolean]`       | Specifies whether the DNS server logs notifications.                                                                                                                                                             |                |
| **Queries**                              |            | `[Boolean]`       | Specifies whether the DNS server allows query packet exchanges to pass through the content filter, such as the **FilterIPAddressList** parameter.                                                                |                |
| **QuestionTransactions**                 |            | `[Boolean]`       | Specifies whether the DNS server logs queries.                                                                                                                                                                   |                |
| **ReceivePackets**                       |            | `[Boolean]`       | Specifies whether the DNS server logs receive packets.                                                                                                                                                           |                |
| **SaveLogsToPersistentStorage**          |            | `[Boolean]`       | Specifies whether the DNS server saves logs to persistent storage.                                                                                                                                               |                |
| **SendPackets**                          |            | `[Boolean]`       | Specifies whether the DNS server logs send packets.                                                                                                                                                              |                |
| **TcpPackets**                           |            | `[Boolean]`       | Specifies whether the DNS server logs TCP packets.                                                                                                                                                               |                |
| **UdpPackets**                           |            | `[Boolean]`       | Specifies whether the DNS server logs UDP packets.                                                                                                                                                               |                |
| **UnmatchedResponse**                    |            | `[Boolean]`       | Specifies whether the DNS server logs unmatched responses.                                                                                                                                                       |                |
| **Update**                               |            | `[Boolean]`       | Specifies whether the DNS server logs updates.                                                                                                                                                                   |                |
| **UseSystemEventLog**                    |            | `[Boolean]`       | Specifies whether the DNS server uses the system event log for logging.                                                                                                                                          |                |
| **WriteThrough**                         |            | `[Boolean]`       | Specifies whether the DNS server logs write-throughs.                                                                                                                                                            |                |

## Description

The DnsServerDiagnostics DSC resource manages the debugging and logging
parameters on a Domain Name System (DNS) server.

If the parameter **DnsServer** is set to `'localhost'` then the resource
can normally use the default credentials (SYSTEM) to configure the DNS server
settings. If using any other value for the parameter **DnsServer** make sure
that the credential the resource is run as have the correct permissions
at the target node and the necessary network traffic is permitted.
It is possible to run the resource with specific credentials using the
built-in parameter **PsDscRunAsCredential**.

## Examples

### Example 1

This configuration will manage a DNS server's diagnostics settings

```powershell
Configuration DnsServerDiagnostics_CurrentNode_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerDiagnostics 'Diagnostics'
        {
            DnsServer                            = 'localhost'
            Answers                              = $true
            EnableLogFileRollover                = $true
            EnableLoggingForLocalLookupEvent     = $true
            EnableLoggingForPluginDllEvent       = $true
            EnableLoggingForRecursiveLookupEvent = $true
            EnableLoggingForRemoteServerEvent    = $true
            EnableLoggingForServerStartStopEvent = $true
            EnableLoggingForTombstoneEvent       = $true
            EnableLoggingForZoneDataWriteEvent   = $true
            EnableLoggingForZoneLoadingEvent     = $true
            EnableLoggingToFile                  = $true
            EventLogLevel                        = 7
            FilterIPAddressList                  = @('10.0.10.1', '10.0.10.2')
            FullPackets                          = $false
            LogFilePath                          = 'd:\dnslogs\dns.log'
            MaxMBFileSize                        = 500000000
            Notifications                        = $true
            Queries                              = $true
            QuestionTransactions                 = $true
            ReceivePackets                       = $false
            SaveLogsToPersistentStorage          = $true
            SendPackets                          = $false
            TcpPackets                           = $false
            UdpPackets                           = $false
            UnmatchedResponse                    = $false
            Update                               = $true
            UseSystemEventLog                    = $true
            WriteThrough                         = $true
        }
    }
}
```

### Example 2

This configuration will manage a DNS server's diagnostics settings

```powershell
Configuration DnsServerDiagnostics_RemoteNode_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerDiagnostics 'Diagnostics'
        {
            DnsServer                            = 'dns1.company.local'
            Answers                              = $true
            EnableLogFileRollover                = $true
            EnableLoggingForLocalLookupEvent     = $true
            EnableLoggingForPluginDllEvent       = $true
            EnableLoggingForRecursiveLookupEvent = $true
            EnableLoggingForRemoteServerEvent    = $true
            EnableLoggingForServerStartStopEvent = $true
            EnableLoggingForTombstoneEvent       = $true
            EnableLoggingForZoneDataWriteEvent   = $true
            EnableLoggingForZoneLoadingEvent     = $true
            EnableLoggingToFile                  = $true
            EventLogLevel                        = 7
            FilterIPAddressList                  = @('10.0.10.1', '10.0.10.2')
            FullPackets                          = $false
            LogFilePath                          = 'd:\dnslogs\dns.log'
            MaxMBFileSize                        = 500000000
            Notifications                        = $true
            Queries                              = $true
            QuestionTransactions                 = $true
            ReceivePackets                       = $false
            SaveLogsToPersistentStorage          = $true
            SendPackets                          = $false
            TcpPackets                           = $false
            UdpPackets                           = $false
            UnmatchedResponse                    = $false
            Update                               = $true
            UseSystemEventLog                    = $true
            WriteThrough                         = $true
        }
    }
}
```

