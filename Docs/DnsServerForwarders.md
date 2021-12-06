# DnsServerForwarders

The DnsServerForwarders DSC configuration manages the DNS forwarder list of a Domain Name System (DNS) server.

If the parameter `EnableReordering` is set to `$false` then the preferred forwarder can be put in the series of forwarder IP addresses.

<br />

## Project Information
|                  |                                                                                                                                  |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://prod1gitlab.mapcom.local/dsc/configurations/DnsServerTasks/-/tree/master/DnsServerTasks/DscResources/DnsServerForwarders |
| **Dependencies** | [DnsServerDsc][DnsServerDsc], [PSDesiredStateConfiguration][PSDesiredStateConfiguration]                                         |
| **Resources**    | [DnsServerForwarder][DnsServerForwarder], [WindowsFeature][WindowsFeature]                                                       |


<br />

## Parameters

<br />

### Table. Attributes of `DnsServerForwarders`

| Parameter            | Attribute | DataType            | Description                                                                                                                                       | Allowed Values |
| -------------------- | --------- | ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| **IPAddresses**      | Write     | `[System.String[]]` | IP addresses of the forwarders                                                                                                                    |                |
| **UseRootHint**      | Write     | `[System.Boolean]`  | Specifies if you want to use root hint or not.                                                                                                    |                |
| **EnableReordering** | Write     | `[System.Boolean]`  | Specifies whether to enable the DNS server to reorder forwarders dynamically.                                                                     |                |
| **Timeout**          | Write     | `[System.UInt32]`   | Specifies the number of seconds that the DNS server waits for a response from the forwarder. The minimum value is 0, and the maximum value is 15. |                |

---

<br />

## Example `DnsServerForwarders`

```yaml
DnsServerForwarders:
  IPAddresses:
    - 192.168.0.20
    - 192.168.0.21
  UseRootHint: false
  EnableReordering: true
  Timeout: 15

```

<br />

## Lookup Options in `Datum.yml`

```yaml
lookup_options:

  DnsServerForwarders:
  	merge_hash: deep
  DnsServerForwarders\IPAddresses:
    merge_baseType_array: Unique
```

<br />

[DnsServerDsc]: https://github.com/dsccommunity/DnsServerDsc
[PSDesiredStateConfiguration]: https://docs.microsoft.com/en-us/powershell/module/psdesiredstateconfiguration/about/about_classes_and_dsc?view=powershell-7.1
[DnsServerForwarder]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerForwarder
[WindowsFeature]: https://docs.microsoft.com/en-us/powershell/scripting/dsc/reference/resources/windows/windowsfeatureresource?view=powershell-7.2