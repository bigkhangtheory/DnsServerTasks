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
| **Name**        | Key        | `[String]` | Specifies the name of a DNS server resource record object.                                               |                                     |
| **IPv4Address** | Key        | `[String]` | Specifies the IPv4 address of a host.                                                                    |                                     |
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
[WindowsFeature]: https://docs.microsoft.com/en-us/powershell/scripting/dsc/reference/resources/windows/windowsfeatureresource?view=powershell-7.2