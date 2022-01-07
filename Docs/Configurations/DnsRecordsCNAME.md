# DnsRecordsCNAME

The **DnsRecordsCNAME** DSC configuration manages CNAME DNS records against a specific zone on a Domain Name System (DNS) server.

<br />

## Project Information
|                  |                                                                                                                              |
| ---------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://prod1gitlab.mapcom.local/dsc/configurations/DnsServerTasks/-/tree/master/DnsServerTasks/DscResources/DnsRecordsCNAME |
| **Dependencies** | [DnsServerDsc][DnsServerDsc], [PSDesiredStateConfiguration][PSDesiredStateConfiguration]                                     |
| **Resources**    | [DnsRecordCname][DnsRecordCname], [WindowsFeature][WindowsFeature]                                                           |


<br />

## Parameters

<br />

### Table. Attributes of `DnsRecordsCNAME`

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

| Parameter      | Attribute  | DataType   | Description                                                                                                | Allowed Values                  |
| :------------- | :--------- | :--------- | :--------------------------------------------------------------------------------------------------------- | :------------------------------ |
| **Name**       | *Required* | `[String]` | Specifies the name of a DNS server resource record object.                                                 |                                 |
| **HostAlias**  | *Required* | `[String]` | Specifies a a canonical name target for a CNAME record. This must be a fully qualified domain name (FQDN). |                                 |
| **TimeToLive** | *Optional* | `[String]` | Specifies the TimeToLive value of the SRV record. Must be in valid TimeSpan string format `dd.hh:mm:ss`.   |                                 |
| **Ensure**     | *Optional* | `[String]` | Whether the host record should be present or removed.                                                      | `Present` *(default)*, `Absent` |

---

<br />

## Example `DnsRecordsCNAME`

```yaml
DnsRecordsCNAME:
  ForwardLookupZones:
    - ZoneName: example.com
      ZoneTTL:  01:00:00
      Records:
        # ---
        - Name:       alias1
          HostAlias:  server1.example.com
        # ---
        - Name:       alias2
          HostAlias:  server2.example.com

    - ZoneName: bigkhangtheory.io
      ZoneTTL:  00:20:00
      Records:
        # ---
        - Name:       alias3
          HostAlias:  server3.bigkhangtheory.io
          TimeToLive: 00:05:00
        # ---
        - Name:       alias4
          HostAlias:  server4.bigkhangtheory.io
```

<br />

## Lookup Options in `Datum.yml`

```yaml
lookup_options:

  DnsRecordsCNAME:
  	merge_hash: deep
  DnsRecordsCNAME\ForwardLookupZones:
    merge_hash_array: UniqueKeyValTuples
    merge_options:
      tuple_keys:
        - ZoneName
  DnsRecordsCNAME\ForwardLookupZones\Records:
    merge_hash_array: UniqueKeyValTuples
    merge_options:
      tuple_keys:
        - Name
        - HostAlias
```

<br />

[DnsServerDsc]: https://github.com/dsccommunity/DnsServerDsc
[PSDesiredStateConfiguration]: https://docs.microsoft.com/en-us/powershell/module/psdesiredstateconfiguration/about/about_classes_and_dsc?view=powershell-7.1
[DnsRecordCname]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordCname
[WindowsFeature]: https://docs.microsoft.com/en-us/powershell/scripting/dsc/reference/resources/windows/windowsfeatureresource?view=powershell-7.2