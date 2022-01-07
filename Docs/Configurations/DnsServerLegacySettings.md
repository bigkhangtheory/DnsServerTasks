# DnsServerLegacySettings

The **DnsServerLegacySettings** DSC resource manages the Domain Name System (DNS) server legacy settings.

If the parameter **DnsServer** is set to `'localhost'` then the resource can normally use the default credentials (SYSTEM) to configure the DNS server settings.

If using any other value for the parameter **DnsServer** make sure that the credential the resource is run as have the correct permissions at the target node and the necessary network traffic is permitted (_WsMan_ protocol).


<br />

## Project Information

|                  |                                                                                                                  |
| ---------------- | ---------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://github.com/bigkhangtheory/DnsServerTasks/tree/master/DnsServerTasks/DscResources/DnsServerLegacySettings |
| **Dependencies** | [DnsServerDsc][DnsServerDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                       |
| **Resources**    | [DnsServerSettingLegacy][DnsServerSettingLegacy], [xWindowsFeature][xWindowsFeature]                             |

<br />

## Parameters

<br />

### Table. Attributes of `DnsServerLegacySettings`

| Parameter                | Attribute | DataType         | Description                                                                                                           | Allowed Values |
| :----------------------- | :-------- | :--------------- | :-------------------------------------------------------------------------------------------------------------------- | :------------- |
| **DnsServer**            |           | `[String]`       | Specifies the DNS server to connect to. Defaults to `localhost`.                                                      |                |
| **DisjointNets**         |           | `[Boolean]`      | Indicates whether the default port binding for a socket used to send queries to remote DNS Servers can be overridden. |                |
| **NoForwarderRecursion** |           | `[Boolean]`      | TRUE if the DNS server does not use recursion when name-resolution through forwarders fails.                          |                |
| **LogLevel**             |           | `[UInt32]`       | Indicates which policies are activated in the Event Viewer system log.                                                |                |
| **Credential**           |           | `[PSCredential]` | Specifies the credential to use when configuring legacy settings on a remote Node.                                    |                |

---

<br />

## Example `DnsServerLegacySettings`

```yaml
DnsServerLegacySettings:
  DisjointNets: true
  NoForwarderRecursion: false
  LogLevel: 50393905
```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  DnsServerLegacySettings:
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
