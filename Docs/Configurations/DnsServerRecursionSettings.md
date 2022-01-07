# DnsServerRecursionSettings

The **DnsServerRecursionSettings** DSC configuration manages recursion settings on a Microsoft Domain Name System (DNS) server.

Recursion occurs when a DNS server queries other DNS servers on behalf of a requesting client, and then sends the answer back to the client.

The property `SecureResponse` that can be set by the cmdlet `Set-DnsServerRecursion` changes the same value as `EnablePollutionProtection` in the configuraion _DnsServerCacheSettings_ does. Use the property `EnablePollutionProtection` in the configuration _DnsServerCacheSettings_ to enforce pollution protection.

<br />

## Project Information

|                  |                                                                                                                     |
| ---------------- | ------------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://github.com/bigkhangtheory/DnsServerTasks/tree/master/DnsServerTasks/DscResources/DnsServerRecursionSettings |
| **Dependencies** | [DnsServerDsc][DnsServerDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                          |
| **Resources**    | [DnsServerRecursion][DnsServerRecursion], [xWindowsFeature][xWindowsFeature]                                        |

<br />

## Parameters

<br />

### Table. Attributes of `DnsServerRecursionSettings`

| Parameter             | Attribute | DataType    | Description                                                                                                                                                                                                                          | Allowed Values |
| :-------------------- | :-------- | :---------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------- |
| **DnsServer**         |           | `[String]`  | The host name of the Domain Name System (DNS) server. Defaults to `localhost`.                                                                                                                                                       |                |
| **Enable**            |           | `[Boolean]` | Specifies whether the server enables recursion.                                                                                                                                                                                      |                |
| **AdditionalTimeout** |           | `[UInt32]`  | Specifies the time interval, in seconds, that a DNS server waits as it uses recursion to get resource records from a remote DNS server. See recommendation in the documentation of [Set-DnsServerRecursion][Set-DnsServerRecursion]. | `1` - `15`     |
| **RetryInterval**     |           | `[UInt32]`  | Specifies elapsed seconds before a DNS server retries a recursive lookup. See recommendation in the documentation of [Set-DnsServerRecursion][Set-DnsServerRecursion].                                                               | `1` - `15`     |
| **Timeout**           |           | `[UInt32]`  | Specifies the number of seconds that a DNS server waits before it stops trying to contact a remote server. See recommendation in the documentation of [Set-DnsServerRecursion][Set-DnsServerRecursion].                              | `1` - `15`     |

---

<br />

## Example `DnsServerRecursionSettings`

```yaml
DnsServerRecursionSettings:
  Enable: true
  AdditionalTimeout: 4
  RetryInterval: 3
  Timeout: 15

```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  DnsServerRecursionSettings:
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
[Set-DnsServerRecursion]: https://docs.microsoft.com/en-us/powershell/module/dnsserver/set-dnsserverrecursion