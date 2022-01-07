# DnsRecordsSRV

The **DnsRecordsSRV** DSC configuration manages SRV DNS records against a specific zone on a Domain Name System (DNS) server.

<br />

## Project Information
|                  |                                                                                                                            |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://prod1gitlab.mapcom.local/dsc/configurations/DnsServerTasks/-/tree/master/DnsServerTasks/DscResources/DnsRecordsSRV |
| **Dependencies** | [DnsServerDsc][DnsServerDsc], [PSDesiredStateConfiguration][PSDesiredStateConfiguration]                                   |
| **Resources**    | [DnsRecordSrv][DnsRecordSrv], [WindowsFeature][WindowsFeature]                                                             |


<br />

## Parameters

<br />

### Table. Attributes of `DnsRecordsSRV`

| Parameter              | Attribute  | DataType        | Description                                                                                         | Allowed Values |
| :--------------------- | :--------- | :-------------- | :-------------------------------------------------------------------------------------------------- | :------------- |
| **DnsServer**          | *Optional* | `[String]`      | Specifies a DNS server. If you do not specify this parameter, the command runs on the local system. |                |
| **ForwardLookupZones** |            | `[Hashtable[]]` | Sepcifies a list of DNS forward lookup zones for which to create the SRV DNS record.                |                |

---

<br />

#### Table. Attributes of `ForwardLookupZones`

| Parameter    | Attribute  | DataType        | Description                                                                                                                  | Allowed Values |
| :----------- | :--------- | :-------------- | :--------------------------------------------------------------------------------------------------------------------------- | :------------- |
| **ZoneName** | *Required* | `[String]`      | Specifies the name of a DNS zone. (Key Parameter)                                                                            |                |
| **ZoneTTL**  | *Optional* | `[String]`      | Specifies the TimeToLive value of all SRV DNS records created in the zone. This value can be overwritten per the SRV record. |                |
| **Records**  |            | `[Hashtable[]]` | Sepcifies a list SRV DNS record to create.                                                                                   |                |

---

<br />

##### Table. Attributes of `Records`

| Parameter        | Attribute  | DataType   | Description                                                                                              | Allowed Values                  |
| :--------------- | :--------- | :--------- | :------------------------------------------------------------------------------------------------------- | :------------------------------ |
| **SymbolicName** | *Required* | `[String]` | Service name for the SRV record. eg: xmpp, ldap, etc. (Key Parameter)                                    |                                 |
| **Protocol**     | *Required* | `[String]` | Service transmission protocol ('TCP' or 'UDP') (Key Parameter)                                           | `TCP`, `UDP`                    |
| **Port**         | *Required* | `[UInt16]` | The TCP or UDP port on which the service is found (Key Parameter)                                        |                                 |
| **Target**       | *Required* | `[String]` | Specifies the Target Hostname or IP Address. (Key Parameter)                                             |                                 |
| **Priority**     | Required   | `[UInt16]` | Specifies the Priority value of the SRV record. (Mandatory Parameter)                                    |                                 |
| **Weight**       | Required   | `[UInt16]` | Specifies the weight of the SRV record. (Mandatory Parameter)                                            |                                 |
| **TimeToLive**   | *Optional* | `[String]` | Specifies the TimeToLive value of the SRV record. Must be in valid TimeSpan string format `dd.hh:mm:ss`. |                                 |
| **Ensure**       | *Optional* | `[String]` | Whether the host record should be present or removed.                                                    | `Present` *(default)*, `Absent` |

---

<br />

## Example `DnsRecordsSRV`

```yaml
DnsRecordsSRV:
  ForwardLookupZones:
    - ZoneName: example.com
      ZoneTTL:  00:05:00
      Records:
      # ---
      - SymbolicName: _gc
        Protocol:     tcp
        Port:         3268
        Target:       ns1.example.com
        Priority:     0
        Weight:       100
      # ---
      - SymbolicName: _kerberos
        Protocol:     tcp
        Port:         88
        Target:       ns1.example.com
        Priority:     0
        Weight:       100
      # ---
      - SymbolicName: _kerberos
        Protocol:     udp
        Port:         88
        Target:       ns1.example.com
        Priority:     0
        Weight:       100
      # ---
      - SymbolicName: _kpasswd
        Protocol:     tcp
        Port:         464
        Target:       ns1.example.com
        Priority:     0
        Weight:       100
      # ---
      - SymbolicName: _kpasswd
        Protocol:     udp
        Port:         464
        Target:       ns1.example.com
        Priority:     0
        Weight:       100
      # ---
      - SymbolicName: _ldap
        Protocol:     tcp
        Port:         389
        Target:       ns1.example.com
        Priority:     0
        Weight:       100
      # ---
      - SymbolicName: ldaps
        Protocol:     tcp
        Port:         636
        Target:       ns1.example.com
        Priority:     0
        Weight:       100
```

<br />

## Lookup Options in `Datum.yml`

```yaml
lookup_options:

  DnsRecordsSRV:
  	merge_hash: deep
  DnsRecordsSRV\ForwardLookupZones:
    merge_hash_array: UniqueKeyValTuple
    merge_options:
      tuple_options:
        - ZoneName
  DnsRecordsSRV\ForwardLookupZones\Records:
    merge_hash_array: UniqueKeyValTuple
    merge_options:
      tuple_options:
        - SymbolicName
        - Protocol
        - Port
        - Target
```

<br />

[DnsServerDsc]: https://github.com/dsccommunity/DnsServerDsc
[PSDesiredStateConfiguration]: https://docs.microsoft.com/en-us/powershell/module/psdesiredstateconfiguration/about/about_classes_and_dsc?view=powershell-7.1
[DnsRecordSrv]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordSrv
[WindowsFeature]: https://docs.microsoft.com/en-us/powershell/scripting/dsc/reference/resources/windows/windowsfeatureresource?view=powershell-7.2