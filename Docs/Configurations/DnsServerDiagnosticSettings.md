# DnsServerDiagnosticSettings

The **DnsServerDiagnosticSettings** DSC configuration manages the debugging and logging parameters on a Domain Name System (DNS) server.

If the parameter **DnsServer** is set to `'localhost'` then the resource can normally use the default credentials (SYSTEM) to configure the DNS server settings.

If using any other value for the parameter **DnsServer** make sure that the credential the resource is run as have the correct permissions at the target node and the necessary network traffic is permitted.

<br />

## Project Information

|                  |                                                                                                                      |
| ---------------- | -------------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://github.com/bigkhangtheory/DnsServerTasks/tree/master/DnsServerTasks/DscResources/DnsServerDiagnosticSettings |
| **Dependencies** | [DnsServerDsc][DnsServerDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                           |
| **Resources**    | [DnsServerDiagnostics][DnsServerDiagnostics], [xWindowsFeature][xWindowsFeature]                                     |

<br />

## Parameters

<br />

### Table. Attributes of `DnsServerDiagnosticSettings`

| Parameter                                | Attribute | DataType          | Description                                                                                                                                                                                                      | Allowed Values |
| :--------------------------------------- | :-------- | :---------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------- |
| **DnsServer**                            |           | `[String]`        | Specifies the DNS server to connect to. Defaults to `localhost`.                                                                                                                                                 |                |
| **Answers**                              |           | `[Boolean]`       | Specifies whether to enable the logging of DNS responses.                                                                                                                                                        |                |
| **EnableLogFileRollover**                |           | `[Boolean]`       | Specifies whether to enable log file rollover.                                                                                                                                                                   |                |
| **EnableLoggingForLocalLookupEvent**     |           | `[Boolean]`       | Specifies whether the DNS server logs local lookup events.                                                                                                                                                       |                |
| **EnableLoggingForPluginDllEvent**       |           | `[Boolean]`       | Specifies whether the DNS server logs dynamic link library (DLL) plug-in events.                                                                                                                                 |                |
| **EnableLoggingForRecursiveLookupEvent** |           | `[Boolean]`       | Specifies whether the DNS server logs recursive lookup events.                                                                                                                                                   |                |
| **EnableLoggingForRemoteServerEvent**    |           | `[Boolean]`       | Specifies whether the DNS server logs remote server events.                                                                                                                                                      |                |
| **EnableLoggingForServerStartStopEvent** |           | `[Boolean]`       | Specifies whether the DNS server logs server start and stop events.                                                                                                                                              |                |
| **EnableLoggingForTombstoneEvent**       |           | `[Boolean]`       | Specifies whether the DNS server logs tombstone events.                                                                                                                                                          |                |
| **EnableLoggingForZoneDataWriteEvent**   |           | `[Boolean]`       | Specifies whether the DNS server logs zone data write events.                                                                                                                                                    |                |
| **EnableLoggingForZoneLoadingEvent**     |           | `[Boolean]`       | Specifies whether the DNS server logs zone load events.                                                                                                                                                          |                |
| **EnableLoggingToFile**                  |           | `[Boolean]`       | Specifies whether the DNS server logs logging-to-file.                                                                                                                                                           |                |
| **EventLogLevel**                        |           | `[System.UInt32]` | Specifies an event log level. Valid values are Warning, Error, and None.                                                                                                                                         |                |
| **FilterIPAddressList**                  |           | `[String[]]`      | Specifies an array of IP addresses to filter. When you enable logging, traffic to and from these IP addresses is logged. If you do not specify any IP addresses, traffic to and from all IP addresses is logged. |                |
| **FullPackets**                          |           | `[Boolean]`       | Specifies whether the DNS server logs full packets.                                                                                                                                                              |                |
| **LogFilePath**                          |           | `[String]`        | Specifies a log file path.                                                                                                                                                                                       |                |
| **MaxMBFileSize**                        |           | `[System.UInt32]` | Specifies the maximum size of the log file. This parameter is relevant if you set **EnableLogFileRollover** and **EnableLoggingToFile** to `$true`.                                                              |                |
| **Notifications**                        |           | `[Boolean]`       | Specifies whether the DNS server logs notifications.                                                                                                                                                             |                |
| **Queries**                              |           | `[Boolean]`       | Specifies whether the DNS server allows query packet exchanges to pass through the content filter, such as the **FilterIPAddressList** parameter.                                                                |                |
| **QuestionTransactions**                 |           | `[Boolean]`       | Specifies whether the DNS server logs queries.                                                                                                                                                                   |                |
| **ReceivePackets**                       |           | `[Boolean]`       | Specifies whether the DNS server logs receive packets.                                                                                                                                                           |                |
| **SaveLogsToPersistentStorage**          |           | `[Boolean]`       | Specifies whether the DNS server saves logs to persistent storage.                                                                                                                                               |                |
| **SendPackets**                          |           | `[Boolean]`       | Specifies whether the DNS server logs send packets.                                                                                                                                                              |                |
| **TcpPackets**                           |           | `[Boolean]`       | Specifies whether the DNS server logs TCP packets.                                                                                                                                                               |                |
| **UdpPackets**                           |           | `[Boolean]`       | Specifies whether the DNS server logs UDP packets.                                                                                                                                                               |                |
| **UnmatchedResponse**                    |           | `[Boolean]`       | Specifies whether the DNS server logs unmatched responses.                                                                                                                                                       |                |
| **Update**                               |           | `[Boolean]`       | Specifies whether the DNS server logs updates.                                                                                                                                                                   |                |
| **UseSystemEventLog**                    |           | `[Boolean]`       | Specifies whether the DNS server uses the system event log for logging.                                                                                                                                          |                |
| **WriteThrough**                         |           | `[Boolean]`       | Specifies whether the DNS server logs write-throughs.                                                                                                                                                            |                |
| **Credential**                           |           | `[PSCredential]`  | Specifies the credential to use when configuring a remote Node.                                                                                                                                                  |                |

---

<br />

## Example `DnsServerDiagnosticSettings`

```yaml
DnsServerDiagnosticSettings:
  Answers: true
  EnableLogFileRollover: true
  EnableLoggingForLocalLookupEvent: true
  EnableLoggingForPluginDllEvent: true
  EnableLoggingForRecursiveLookupEvent: true
  EnableLoggingForRemoteServerEvent: true
  EnableLoggingForServerStartStopEvent: true
  EnableLoggingForTombstoneEvent: true
  EnableLoggingForZoneDataWriteEvent: true
  EnableLoggingForZoneLoadingEvent: true
  EnableLoggingToFile: True
  EventLogLevel: 4
  FilterIPAddressList:
    - 10.101.1.11
    - 10.101.1.12
  FullPackets: false
  LogFilePath: C:\Windows\System32\dns\dnsdiag.log
  MaxMBFileSize: 500000000
  Notifications: true
  Queries: true
  QuestionTransactions: true
  ReceivePackets: false
  SaveLogsToPersistentStorage: true
  SendPackets: false
  TcpPackets: false
  UdpPackets: false
  UnmatchedResponse: false
  Update: true
  UseSystemEventLog: true
  WriteThrough: true

```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  DnsServerDiagnosticSettings:
    merge_hash: deep

```

<br />

[DnsServerDsc]: https://github.com/dsccommunity/DnsServerDsc
[PSDesiredStateConfiguration]: https://docs.microsoft.com/en-us/powershell/module/psdesiredstateconfiguration/about/about_classes_and_dsc?view=powershell-7.1
[DnsRecordA]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordA
[DnsRecordAaaa]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordAaaa
[DnsRecordAaaaScoped]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordAaaaScoped
[DnsRecordAScoped]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordAScoped
[DnsRecordBase]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordBase
[DnsRecordCname]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordCname
[DnsRecordCnameScoped]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordCnameScoped
[DnsRecordMx]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordMx
[DnsRecordMxScoped]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordMxScoped
[DnsRecordNs]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordNs
[DnsRecordNsScoped]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordNsScoped
[DnsRecordPtr]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordPtr
[DnsRecordSrv]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordSrv
[DnsRecordSrvScoped]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordSrvScoped
[DnsServerCache]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerCache
[DnsServerDsc]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerDsc
[DnsServerDsSetting]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerDsSetting
[DnsServerEDns]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerEDns
[DnsServerRecursion]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerRecursion
[DnsServerScavenging]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerScavenging
[DnsServerClientSubnet]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerClientSubnet
[DnsServerConditionalForwarder]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerConditionalForwarder
[DnsServerDiagnostics]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerDiagnostics
[DnsServerForwarder]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerForwarder
[DnsServerPrimaryZone]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerPrimaryZone
[DnsServerRootHint]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerRootHint
[DnsServerSecondaryZone]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerSecondaryZone
[DnsServerSetting]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerSetting
[DnsServerSettingLegacy]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerSettingLegacy
[DnsServerZoneAging]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerZoneAging
[DnsServerZoneScope]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerZoneScope
[DnsServerZoneTransfer]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerZoneTransfer
[xWindowsFeature]: https://github.com/dsccommunity/xPSDesiredStateConfiguration
