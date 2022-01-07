# DnsRecordsA

The **DnsRecordsA** DSC configuration manages A DNS records against a specific zone on a Domain Name System (DNS) server.

<br />

## Project Information
|                  |                                                                                                                          |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------ |
| **Source**       | https://prod1gitlab.mapcom.local/dsc/configurations/DnsServerTasks/-/tree/master/DnsServerTasks/DscResources/DnsRecordsA |
| **Dependencies** | [DnsServerDsc][DnsServerDsc], [PSDesiredStateConfiguration][PSDesiredStateConfiguration]                                 |
| **Resources**    | [DnsRecordA][DnsRecordA], [WindowsFeature][WindowsFeature]                                                               |

<br />

## Parameters

<br />

### Table. Attributes of `DnsRecordsA`

| Parameter              | Attribute  | DataType        | Description                                                                                         | Allowed Values |
| :--------------------- | :--------- | :-------------- | :-------------------------------------------------------------------------------------------------- | :------------- |
| **DnsServer**          | *Optional* | `[String]`      | Specifies a DNS server. If you do not specify this parameter, the command runs on the local system. |                |
| **ForwardLookupZones** |            | `[Hashtable[]]` | Sepcifies a list of DNS forward lookup zones for which to create the A DNS record.                  |                |

---

<br />

#### Table. Attributes of `ForwardLookupZones`

| Parameter    | Attribute  | DataType        | Description                                                                                                              | Allowed Values |
| :----------- | :--------- | :-------------- | :----------------------------------------------------------------------------------------------------------------------- | :------------- |
| **ZoneName** | *Required* | `[String]`      | Specifies the name of a DNS zone. (Key Parameter)                                                                        |                |
| **ZoneTTL**  | *Optional* | `[String]`      | Specifies the TimeToLive value of all A DNS records created in the zone. This value can be overwritten per the A record. |                |
| **Records**  |            | `[Hashtable[]]` | Sepcifies a list A DNS record to create.                                                                                 |                |

---

<br />

##### Table. Attributes of `Records`

| Parameter       | Attribute  | DataType   | Description                                                                                              | Allowed Values                      |
| :-------------- | :--------- | :--------- | :------------------------------------------------------------------------------------------------------- | :---------------------------------- |
| **Name**        | *Required* | `[String]` | Specifies the name of a DNS server resource record object.                                               |                                     |
| **IPv4Address** | *Required* | `[String]` | Specifies the IPv4 address of a host.                                                                    |                                     |
| **TimeToLive**  | *Optional* | `[String]` | Specifies the TimeToLive value of the SRV record. Must be in valid TimeSpan string format `dd.hh:mm:ss`. |                                     |
| **Ensure**      | *Optional* | `[String]` | Whether the host record should be present or removed.                                                    | `'Present'` *(default)*, `'Absent'` |

---

<br />

## Example `DnsRecordsA`

```yaml
DnsRecordsA:
  DnsServer: ns1.example.com
  ForwardLookupZones:
    - ZoneName: example.com
      ZoneTTL:  00:15:00
      Records:
        # ---
        - Name:         server1
          IPv4Address:  192.168.1.2
        # ---
        - Name:         server2
          IPv4Address:  192.168.1.3
          TimeToLive:   00:05:00

    - ZoneName: bigkhangtheory.io
      ZoneTTL:  01:00:00
      Records:
        # ---
        - Name:         server3
          IPv4Address:  192.168.2.2
        # ---
        - Name:         server4
          IPv4Address:  192.168.2.3
```

<br />

## Lookup Options in `Datum.yml`

```yaml
lookup_options:

  DnsRecordsA:
  	merge_hash: deep
  DnsRecordsA\ForwardLookupZones:
    merge_hash_array: UniqueKeyValTuples
    merge_options:
      tuple_keys:
        - ZoneName
  DnsRecordsA\ForwardLookupZones\Records:
    merge_hash_array: UniqueKeyValTuples
    merge_options:
      tuple_keys:
        - Name
        - IPv4Address
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
[WindowsFeature]: https://docs.microsoft.com/en-us/powershell/scripting/dsc/reference/resources/windows/windowsfeatureresource?view=powershell-7.2