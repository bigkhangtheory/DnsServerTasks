# DnsRecordsNS

The **DnsRecordsNS** DSC configuration manages NS DNS records against a specific zone on a Domain Name System (DNS) server.

<br />

## Project Information
|                  |                                                                                                                           |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://prod1gitlab.mapcom.local/dsc/configurations/DnsServerTasks/-/tree/master/DnsServerTasks/DscResources/DnsRecordsNS |
| **Dependencies** | [DnsServerDsc][DnsServerDsc], [PSDesiredStateConfiguration][PSDesiredStateConfiguration]                                  |
| **Resources**    | [DnsRecordNs][DnsRecordNs], [WindowsFeature][WindowsFeature]                                                              |


<br />

## Parameters

<br />

### Table. Attributes of `DnsRecordsNS`

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

| Parameter      | Attribute  | DataType          | Description                                                                                                                                  | Allowed Values                  |
| :------------- | :--------- | :---------------- | :------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------ |
| **DomainName** | Key        | `[System.String]` | Specifies the fully qualified DNS domain name for which the NameServer is authoritative. It must be a subdomain the zone or the zone itself. |                                 |
| **NameServer** | Key        | `[System.String]` | Specifies the name server of a domain as FQDN.                                                                                               |                                 |
| **TimeToLive** | *Optional* | `[String]`        | Specifies the TimeToLive value of the SRV record. Must be in valid TimeSpan string format `dd.hh:mm:ss`.                                     |                                 |
| **Ensure**     | *Optional* | `[String]`        | Whether the host record should be present or removed.                                                                                        | `Present` *(default)*, `Absent` |

---

<br />

## Example `DnsRecordsNS`

```yaml
DnsRecordsNS:
  ForwardLookupZones:
    - ZoneName: example.com
      ZoneTTL:  01:00:00
      Records:
        # ---
        - DomainName: example.com
          NameServers:
            - ns1.example.com
            - ns2.example.com
        # ---
        - DomainName: "*.example.com"
          TimeToLive: 00:30:00
          NameServers:
            - ns1.example.com
            - ns2.example.com
    # ---
    - ZoneName: bigkhangtheory.io
      ZoneTTL:  01:00:00
      Records:
        # ---
        - DomainName: bigkhangtheory.io
          NameServers:
            - ns1.example.com
            - ns2.example.com

```

<br />

## Lookup Options in `Datum.yml`

```yaml
lookup_options:

  DnsRecordsNS:
  	merge_hash: deep
  DnsRecordsNS\ForwardLookupZones:
    merge_hash_array: UniqueKeyValTuples
    merge_options:
      tuple_keys:
        - ZoneName
  DnsRecordsNS\ForwardLookupZones\Records:
    merge_hash_array: UniqueKeyValTuples
    merge_options:
      tuple_keys:
        - DomainName
  DnsRecordsNS\ForwardLookupZones\Records\NameServers:
    merge_baseType_array: Unique
```

<br />

[DnsServerDsc]: https://github.com/dsccommunity/DnsServerDsc
[PSDesiredStateConfiguration]: https://docs.microsoft.com/en-us/powershell/module/psdesiredstateconfiguration/about/about_classes_and_dsc?view=powershell-7.1
[DnsRecordNs]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordNs
[WindowsFeature]: https://docs.microsoft.com/en-us/powershell/scripting/dsc/reference/resources/windows/windowsfeatureresource?view=powershell-7.2