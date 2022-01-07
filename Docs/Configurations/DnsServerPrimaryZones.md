# DnsServerPrimaryZones

The **DnsServerPrimaryZones** DSC resource manages a standalone file-backed Primary zone on a given Domain Name System (DNS) server.

<br />

## Project Information

|                  |                                                                                                                |
| ---------------- | -------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://github.com/bigkhangtheory/DnsServerTasks/tree/master/DnsServerTasks/DscResources/DnsServerPrimaryZones |
| **Dependencies** | [DnsServerDsc][DnsServerDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                     |
| **Resources**    | [DnsServerPrimaryZone][DnsServerPrimaryZone], [xWindowsFeature][xWindowsFeature]                               |

<br />

## Parameters

<br />

### Table. Attributes of `DnsServerPrimaryZones`

| Parameter        | Attribute | DataType        | Description                                                         | Allowed Values |
| :--------------- | :-------- | :-------------- | :------------------------------------------------------------------ | :------------- |
| **PrimaryZones** |           | `[Hashtable[]]` | Specifies a list of DNS Primary Zones to create on the target node. |                |

---

#### Table. Attributes of `PrimaryZones`

| Parameter         | Attribute  | DataType   | Description                                                                             | Allowed Values               |
| :---------------- | :--------- | :--------- | :-------------------------------------------------------------------------------------- | :--------------------------- |
| **Name**          | *Required* | `[String]` | Name of the DNS Server primary zone                                                     |                              |
| **ZoneFile**      |            | `[String]` | Name of the DNS Server primary zone file. If not specified, defaults to 'ZoneName.dns'. |                              |
| **DynamicUpdate** |            | `[String]` | Primary zone dynamic DNS update option. Defaults to `'None'`.                           | `None`, `NonSecureAndSecure` |
| **Ensure**        |            | `[String]` | Whether the DNS zone should be present or absent                                        | `Present`, `Absent`          |

---

<br />

## Example `DnsServerPrimaryZones`

```yaml
DnsServerPrimaryZones:
  PrimaryZones:
    - Name:          PrimaryZone1
      ZoneFile:      MyZone.dns
      DynamicUpdate: NonSecureAndSecure
      Ensure:        Present

    - Name: PrimaryZone2

```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  DnsServerPrimaryZones:
    merge_hash: deep
  DnsServerPrimaryZones\PrimaryZones:
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
