# DnsServerClientSubnets

The **DnsServerClientSubnets** DSC configuration manages DNS Client Subnets on a Domain Name System (DNS) server.

A client subnet is a group of IP subnets that represent a logical group, for example, a geographical area, a datacenter, or a trusted resolver fleet.

You can use client subnets in criteria in DNS policies. Multiple DNS policies can refer to the same client subnet.

<br />

## Project Information

|                  |                                                                                                                 |
| ---------------- | --------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://github.com/bigkhangtheory/DnsServerTasks/tree/master/DnsServerTasks/DscResources/DnsServerClientSubnets |
| **Dependencies** | [DnsServerDsc][DnsServerDsc], [xPSDesiredStateConfiguration][xPSDesiredStateConfiguration]                      |
| **Resources**    | [DnsServerClientSubnet][DnsServerClientSubnet], [xWindowsFeature][xWindowsFeature]                              |

<br />

## Parameters

<br />

### Table. Attributes of `DnsServerClientSubnets`

| Parameter         | Attribute | DataType        | Description                                       | Allowed Values |
| :---------------- | :-------- | :-------------- | :------------------------------------------------ | :------------- |
| **ClientSubnets** |           | `[Hashtable[]]` | Specifies a list of DNS Client Subnets to create. |                |

---

#### Table. Attributes of `ClientSubnets`

| Parameter      | Attribute  | DataType     | Description                                                                    | Allowed Values      |
| :------------- | :--------- | :----------- | :----------------------------------------------------------------------------- | :------------------ |
| **Name**       | *Required* | `[String]`   | Specifies the name of the client subnet.                                       |                     |
| **IPv4Subnet** |            | `[String[]]` | Specify an array (1 or more values) of IPv4 Subnet addresses in CIDR Notation. |                     |
| **IPv6Subnet** |            | `[String[]]` | Specify an array (1 or more values) of IPv6 Subnet addresses in CIDR Notation. |                     |
| **Ensure**     |            | `[String]`   | Should this DNS server client subnet be present or absent                      | `Present`, `Absent` |

---

<br />

## Example `DnsServerClientSubnets`

```yaml
DnsServerClientSubnets:
  ClientSubnets:
    - Name: SITE-1
      Ipv4Subnet:
        - 10.200.16.0/24
        - 10.200.17.0/24
        - 10.200.18.0/23
        - 10.200.20.0/24
        - 10.200.21.0/24
        - 10.200.22.0/24
        - 10.200.23.0/24
      Ensure: Present

    - Name: SITE-2
      Ipv4Subnet:
        - 10.200.32.0/24
        - 10.200.33.0/24
        - 10.200.34.0/23
        - 10.200.36.0/24
        - 10.200.37.0/24
        - 10.200.38.0/24
        - 10.200.39.0/24
      Ensure: Present
```

<br />

## Lookup Options in Datum.yml

```yaml
lookup_options:

  DnsServerClientSubnets:
    merge_hash: deep
  DnsServerClientSubnets\ClientSubnets:
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
