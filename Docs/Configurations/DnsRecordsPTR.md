# DnsRecordsPTR

The **DnsRecordsPTR** DSC configuration manages PTR DNS records against a specific zone on a Domain Name System (DNS) server.

<br />

## Project Information
|                  |                                                                                                                            |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://prod1gitlab.mapcom.local/dsc/configurations/DnsServerTasks/-/tree/master/DnsServerTasks/DscResources/DnsRecordsPTR |
| **Dependencies** | [DnsServerDsc][DnsServerDsc], [PSDesiredStateConfiguration][PSDesiredStateConfiguration]                                   |
| **Resources**    | [DnsRecordPtr][DnsRecordPtr], [WindowsFeature][WindowsFeature]                                                             |


<br />

## Parameters

<br />

### Table. Attributes of `DnsRecordsPTR`

| Parameter              | Attribute  | DataType        | Description                                                                                         | Allowed Values |
| :--------------------- | :--------- | :-------------- | :-------------------------------------------------------------------------------------------------- | :------------- |
| **DnsServer**          | *Optional* | `[String]`      | Specifies a DNS server. If you do not specify this parameter, the command runs on the local system. |                |
| **ReverseLookupZones** |            | `[Hashtable[]]` | Sepcifies a list of DNS reverse lookup zones for which to create the PTR DNS record.                |                |

---

<br />

#### Table. Attributes of `ReverseLookupZones`

| Parameter    | Attribute  | DataType        | Description                                                                                                              | Allowed Values |
| :----------- | :--------- | :-------------- | :----------------------------------------------------------------------------------------------------------------------- | :------------- |
| **ZoneName** | *Required* | `[String]`      | Specifies the name of a DNS zone. (Key Parameter)                                                                        |                |
| **ZoneTTL**  | *Optional* | `[String]`      | Specifies the TimeToLive value of all A DNS records created in the zone. This value can be overwritten per the A record. |                |
| **Records**  |            | `[Hashtable[]]` | Sepcifies a list A DNS record to create.                                                                                 |                |

---

<br />

##### Table. Attributes of `Records`

| Parameter      | Attribute  | DataType   | Description                                                                                              | Allowed Values                  |
| :------------- | :--------- | :--------- | :------------------------------------------------------------------------------------------------------- | :------------------------------ |
| **IpAddress**  | *Required* | `[String]` | Specifies the IP address to which the record is associated (Can be either IPv4 or IPv6. (Key Parameter)  |                                 |
| **Name**       | *Required* | `[String]` | Specifies the FQDN of the host when you add a PTR resource record. (Key Parameter)                       |                                 |
| **TimeToLive** | *Optional* | `[String]` | Specifies the TimeToLive value of the SRV record. Must be in valid TimeSpan string format `dd.hh:mm:ss`. |                                 |
| **Ensure**     | *Optional* | `[String]` | Whether the host record should be present or removed.                                                    | `Present` *(default)*, `Absent` |

---

<br />

## Example `DnsRecordsPTR`

```yaml
DnsRecordsPTR:
  DnsServer: ns1.example.com
  ReverseLookupZones:
    - ZoneName: 1.168.192.in-addr.arpa
      Records:
        # ---
        - IPAddress:  192.168.1.2
          Name:       server1
        # ---
        - IPAddress:  192.168.1.3
          Name:       server2
          TimeToLive: 00:05:00

    - ZoneName: 2.168.192.in-addr.arpa
      ZoneTTL:  01:00:00
      Records:
        # ---
        - IPAddress:  192.168.2.2
          Name:       server3
        # ---
        - IPAddress:  192.168.2.3
          Name:       server4
```

<br />

## Lookup Options in `Datum.yml`

```yaml
lookup_options:

  DnsRecordsPTR:
  	merge_hash: deep
  DnsRecordsPTR\ReverseLookupZones:
    merge_hash_array: UniqueKeyValTuple
    merge_options:
      tuple_options:
        - ZoneName
  DnsRecordsPTR\ReverseLookupZones\Records:
    merge_hash_array: UniqueKeyValTuple
    merge_options:
      tuple_options:
        - IpAddress
```

<br />

[DnsServerDsc]: https://github.com/dsccommunity/DnsServerDsc
[PSDesiredStateConfiguration]: https://docs.microsoft.com/en-us/powershell/module/psdesiredstateconfiguration/about/about_classes_and_dsc?view=powershell-7.1
[DnsRecordPtr]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordPtr
[WindowsFeature]: https://docs.microsoft.com/en-us/powershell/scripting/dsc/reference/resources/windows/windowsfeatureresource?view=powershell-7.2