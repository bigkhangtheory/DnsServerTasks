# DnsServerConditionalForwarders

The **DnsServerConditionalForwarders** DSC configuration manages a conditional forwarder on a Domain Name System (DNS) server.

You can manage the master servers, forwarder time-out, recursion, recursion scope, and directory partition name for a conditional forwarder zone.

<br />

## Project Information

|                  |                                                                                                                         |
| ---------------- | ----------------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://github.com/bigkhangtheory/DnsServerTasks/tree/master/DnsServerTasks/DscResources/DnsServerConditionalForwarders |
| **Dependencies** | [DnsServerDsc][DnsServerDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                              |
| **Resources**    | [DnsServerConditionalForwarder][DnsServerConditionalForwarder], [xWindowsFeature][xWindowsFeature]                      |

<br />

## Parameters

<br />

### Table. Attributes of `DnsServerConditionalForwarders`

| Parameter                 | Attribute | DataType        | Description                                                                            | Allowed Values |
| :------------------------ | :-------- | :-------------- | :------------------------------------------------------------------------------------- | :------------- |
| **ConditionalForwarders** |           | `[Hashtable[]]` | Specifies a list of DNS Conditional Forwarders to configure on a Microsoft DNS Server. |                |

---

#### Table. Attributes of ``

| Parameter                  | Attribute  | DataType     | Description                                                                                                                               | Allowed Values                                 |
| :------------------------- | :--------- | :----------- | :---------------------------------------------------------------------------------------------------------------------------------------- | :--------------------------------------------- |
| **Name**                   | *Required* | `[String]`   | The name of the zone to manage.                                                                                                           |                                                |
| **MasterServers**          |            | `[String[]]` | The IP addresses the forwarder should use. Mandatory if Ensure is present.                                                                |                                                |
| **ReplicationScope**       |            | `[String]`   | Whether the conditional forwarder should be replicated in AD, and the scope of that replication. Default is `None`.                       | `None`, `Custom`, `Domain`, `Forest`, `Legacy` |
| **DirectoryPartitionName** |            | `[String]`   | The name of the directory partition to use when the ReplicationScope is `Custom`. This value is ignored for all other replication scopes. |                                                |
| **Ensure**                 |            | `[String]`   | Specify whether the Conditional Forwarder is absent or present.                                                                           | `Present`, `Absent`                            |

---

<br />

## Example `DnsServerConditionalForwarders`

```yaml
DnsServerConditionalForwarders:
  ConditionalForwarders:
    - Name: SharedServices
      MasterServers:
        - 10.0.1.10
        - 10.0.2.10
      ReplicationScope: Forest
    - Name: Oxy
      MasterServers:
        - 10.0.3.10
      ReplicationScope: Forest

```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  DnsServerConditionalForwarders:
    merge_hash: deep
  DnsServerConditionalForwarders\ConditionalForwarders:
    merge_hash_array: UniqueKeyValTuples
    merge_options:
      tuple_keys:
        - Name

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
