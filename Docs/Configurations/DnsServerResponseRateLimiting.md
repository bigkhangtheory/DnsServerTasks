# DnsServerResponseRateLimiting

The **DnsServerResponseRateLimiting** DSC Configuration manages Response Rate Limiting (RRL) on a Windows DNS server.

<br />

## Project Information

|                  |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Source**       | https://github.com/bigkhangtheory/DnsServerTasks/tree/master/DnsServerTasks/DscResources/DnsServerResponseRateLimiting                                                                                                                                                                                                                                                                                                                                                                                             |
| **Dependencies** | [Get-DnsServerResponseRateLimiting][Get-DnsServerResponseRateLimiting], [Set-DnsServerResponseRateLimiting][Set-DnsServerResponseRateLimiting], [Add-DnsServerResponseRateLimitingExceptionlist][Add-DnsServerResponseRateLimitingExceptionlist], [Get-DnsServerResponseRateLimitingExceptionlist][Get-DnsServerResponseRateLimitingExceptionlist], [Set-DnsServerResponseRateLimitingExceptionlist][Set-DnsServerResponseRateLimitingExceptionlist], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration] |
| **Resources**    | [Script][Script]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |

<br />

## Parameters

<br />

### Table. Attributes of `DnsServerResponseRateLimiting`

| Parameter          | Attribute | DataType        | Description                                                                                                                                                                                                                                                                                                      | Allowed Values                             |
| :----------------- | :-------- | :-------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----------------------------------------- |
| **Mode**           |           | `[String]`      | Specifies the state of RRL on the DNS server. If the mode is set to LogOnly the DNS server performs all the RRL calculations but instead of taking the preventive actions (dropping or truncating responses), it only logs the potential actions as if RRL were enabled and continues with the normal responses. | `Enable` *(Default)*, `Disable`, `LogOnly` |
| **ErrorsPerSec**   |           | `[UInt32]`      | Specifies the maximum number of times that the server can send an error response to a client within a one-second interval. The error responses include: **REFUSED**, **FORMER** and **SERVFAIL**                                                                                                                 |                                            |
| **ReponsesPerSec** |           | `[UInt32]`      | Specifies the maximum number of times that the server sends a client the same response within a one-second interval.                                                                                                                                                                                             |                                            |
| **Records**        |           | `[Hashtable[]]` | Specifies a list of Response Rate Limiting exception lists on a DNS Server.                                                                                                                                                                                                                                      |                                            |

---

#### Table. Attributes of `Reords`

| Parameter | Attribute  | DataType   | Description                                                                                                                                         | Allowed Values                    |
| :-------- | :--------- | :--------- | :-------------------------------------------------------------------------------------------------------------------------------------------------- | :-------------------------------- |
| **Name**  | *Required* | `[String]` | Specifies the name of an Response Rate Limiting exception list.                                                                                     |                                   |
| **Fqdn**  | *Required* | `[String]` | Specifies FQDN values for the exception list. The value must have the following format: `[operator], val1, val2, ...; [operator], val3, val4, ...`. | Valid `[operators]`: `EQ` or `NE` |

---

<br />

## Example `DnsServerResponseRateLimiting`

```yaml
DnsServerResponseRateLimiting:
  Mode: Enable
  ErrorsPerSec: 10
  ResponsesPerSec: 10
  Exceptions:
    - Name: ExceptionListSafe
      Fqdn: EQ,*.contoso.com

```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  DnsServerResponseRateLimiting:
    merge_hash: deep
  DnsServerResponseRateLimiting\Exceptions:
    merge_hash_array: UniqueKeyValTuples
    merge_options:
      tuple_keys:
        - Name
        - Fqdn

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
[Script]: https://github.com/dsccommunity/xPSDesiredStateConfiguration
[xWindowsFeature]: https://github.com/dsccommunity/xPSDesiredStateConfiguration

[Get-DnsServerResponseRateLimiting]: https://docs.microsoft.com/en-us/powershell/module/dnsserver/get-dnsserverresponseratelimiting?view=windowsserver2022-ps&viewFallbackFrom=win10-ps
[Set-DnsServerResponseRateLimiting]: https://docs.microsoft.com/en-us/powershell/module/dnsserver/set-dnsserverresponseratelimiting?view=windowsserver2022-ps&viewFallbackFrom=win10-ps
[Add-DnsServerResponseRateLimitingExceptionlist]: https://docs.microsoft.com/en-us/powershell/module/dnsserver/add-dnsserverresponseratelimitingexceptionlist?view=windowsserver2022-ps&viewFallbackFrom=win10-ps
[Get-DnsServerResponseRateLimitingExceptionlist]: https://docs.microsoft.com/en-us/powershell/module/dnsserver/get-dnsserverresponseratelimitingexceptionlist?view=windowsserver2022-ps&viewFallbackFrom=win10-ps
[Set-DnsServerResponseRateLimitingExceptionlist]: https://docs.microsoft.com/en-us/powershell/module/dnsserver/set-dnsserverresponseratelimitingexceptionlist?view=windowsserver2022-ps&viewFallbackFrom=win10-ps