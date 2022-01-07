# DnsServerRootHints

The **DnsServerRootHints** DSC configuration manages root hints on a Domain Name System (DNS) server.

<br />

## Project Information

|                  |                                                                                                             |
| ---------------- | ----------------------------------------------------------------------------------------------------------- |
| **Source**       | https://github.com/bigkhangtheory/DnsServerTasks/tree/master/DnsServerTasks/DscResources/DnsServerRootHints |
| **Dependencies** | [DnsServerDsc][DnsServerDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                  |
| **Resources**    | [DnsServerRootHint][DnsServerRootHint], [xWindowsFeature][xWindowsFeature]                                  |

<br />

## Parameters

<br />

### Table. Attributes of `DnsServerRootHints`

| Parameter     | Attribute  | DataType        | Description                                                                             | Allowed Values                                         |
| :------------ | :--------- | :-------------- | :-------------------------------------------------------------------------------------- | :----------------------------------------------------- |
| **RootHints** | *Required* | `[Hashtable[]]` | Set of root hints. Each hashtable defines a name server. Key and value must be strings. | See [Root Hint Nameservers](####root-hint-nameservers) |

---

#### Root Hint Nameservers

The valid list of Root Nameservers include:

- A.ROOT-SERVERS.NET
- B.ROOT-SERVERS.NET
- C.ROOT-SERVERS.NET
- D.ROOT-SERVERS.NET
- E.ROOT-SERVERS.NET
- F.ROOT-SERVERS.NET
- G.ROOT-SERVERS.NET
- H.ROOT-SERVERS.NET
- I.ROOT-SERVERS.NET
- J.ROOT-SERVERS.NET
- K.ROOT-SERVERS.NET
- L.ROOT-SERVERS.NET
- M.ROOT-SERVERS.NET

---

<br />

## Example `DnsServerRootHints`

```yaml
DnsServerRootHints:
  RootHints:
    A.ROOT-SERVERS.NET.: 198.41.0.4
    B.ROOT-SERVERS.NET.: 199.9.14.201
    C.ROOT-SERVERS.NET.: 192.33.4.12
    D.ROOT-SERVERS.NET.: 199.7.91.13
```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  DnsServerRootHints:
    merge_hash: deep
  DnsServerRootHints\RootHints:
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
