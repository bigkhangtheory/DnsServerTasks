# DnsRecordsMX

The **DnsRecordsMX** DSC configuration manages MX DNS records against a specific zone on a Domain Name System (DNS) server.

<br />

## Project Information
|                  |                                                                                                                           |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://prod1gitlab.mapcom.local/dsc/configurations/DnsServerTasks/-/tree/master/DnsServerTasks/DscResources/DnsRecordsMX |
| **Dependencies** | [DnsServerDsc][DnsServerDsc], [PSDesiredStateConfiguration][PSDesiredStateConfiguration]                                  |
| **Resources**    | [DnsRecordMx][DnsRecordMx], [WindowsFeature][WindowsFeature]                                                              |


<br />

## Parameters

<br />

### Table. Attributes of `DnsRecordsMX`

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

| Parameter        | Attribute  | DataType   | Description                                                                                                                                       | Allowed Values                  |
| :--------------- | :--------- | :--------- | :------------------------------------------------------------------------------------------------------------------------------------------------ | :------------------------------ |
| **EmailDomain**  | Key        | `[String]` | Everything after the '@' in the email addresses supported by this mail exchanger. It must be a subdomain the zone or the zone itself.             |                                 |
| **MailExchange** | Key        | `[String]` | FQDN of the server handling email for the specified email domain. This FQDN must resolve to an IP address and cannot reference a CNAME record.    |                                 |
| **Priority**     | *Required* | `[UInt16]` | Specifies the priority for this MX record among other MX records that belong to the same email domain, where a lower value has a higher priority. |                                 |
| **TimeToLive**   | *Optional* | `[String]` | Specifies the TimeToLive value of the SRV record. Must be in valid TimeSpan string format `dd.hh:mm:ss`.                                          |                                 |
| **Ensure**       | *Optional* | `[String]` | Whether the host record should be present or removed.                                                                                             | `Present` *(default)*, `Absent` |

---

<br />

## Example `DnsRecordsMX`

```yaml
DnsServer: ns1.example.com
ForwardLookupZones:
  - ZoneName: example.com
    ZoneTTL:  01:00:00
    Records:
      # ---
      - EmailDomain:  example.com
        MailExchange: smtp1.example.com
        Priority:     10
      # ---
      - EmailDomain:  "*.example.com"
        MailExchange: smtp2.example.com
        Priority:     100

  - ZoneName: bigkhangtheory.io
    ZoneTTL:  1.00:00:00
    Records:
      # ---
      - EmailDomain:  bigkhangtheory.io
        MailExchange: smtp1.bigkhangtheory.io
        Priority:     10
      # ---
      - EmailDomain:  "*.bigkhangtheory.io"
        MailExchange: smtp2.bigkhangtheory.io
        Priority:     100
        TimeToLive:   15.00:00:00

```

<br />

## Lookup Options in `Datum.yml`

```yaml
lookup_options:

  DnsRecordsMX:
  	merge_hash: deep
  DnsRecordsMX\ForwardLookupZones:
    merge_hash_array: UniqueKeyValTuples
    merge_options:
      tuple_keys:
        - ZoneName
  DnsRecordsMX\ForwardLookupZones\Records:
    merge_hash_array: UniqueKeyValTuples
    merge_options:
      tuple_keys:
        - EmailDomain
        - MailExchange
        - Priority
```

<br />

[DnsServerDsc]: https://github.com/dsccommunity/DnsServerDsc
[PSDesiredStateConfiguration]: https://docs.microsoft.com/en-us/powershell/module/psdesiredstateconfiguration/about/about_classes_and_dsc?view=powershell-7.1
[DnsRecordMx]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordMx
[WindowsFeature]: https://docs.microsoft.com/en-us/powershell/scripting/dsc/reference/resources/windows/windowsfeatureresource?view=powershell-7.2