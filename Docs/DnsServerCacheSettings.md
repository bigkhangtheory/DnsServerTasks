# DnsServerCacheSettings

The DnsServerCacheSettings DSC configuration manages cache settings on a Microsoft Domain Name System (DNS) server.

<br />

## Project Information
|                  |                                                                                                                                     |
| ---------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://prod1gitlab.mapcom.local/dsc/configurations/DnsServerTasks/-/tree/master/DnsServerTasks/DscResources/DnsServerCacheSettings |
| **Dependencies** | [DnsServerDsc][DnsServerDsc], [PSDesiredStateConfiguration][PSDesiredStateConfiguration]                                            |
| **Resources**    | [DnsServerCache][DnsServerCache], [WindowsFeature][WindowsFeature]                                                                  |


<br />

## Parameters

<br />

### Table. Attributes of `DnsServerCacheSettings`

| Parameter                            | Attribute | DataType           | Description                                                                                                                                                                                                                                                                                                                                                                                                                          | Allowed Values |
| ------------------------------------ | --------- | ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------- |
| **DnsServer**                        | Key       | `[System.String]`  | The host name of the Domain Name System (DNS) server, or use `'localhost'` for the current node.                                                                                                                                                                                                                                                                                                                                     |                |
| **IgnorePolicies**                   | Write     | `[System.Boolean]` | Specifies whether to ignore policies for this cache.                                                                                                                                                                                                                                                                                                                                                                                 |                |
| **LockingPercent**                   | Write     | `[System.UInt32]`  | Specifies a percentage of the original Time to Live (TTL) value that caching can consume. Cache locking is configured as a percent value. For example, if the cache locking value is set to `50`, the DNS server does not overwrite a cached entry for half of the duration of the TTL. If the cache locking percent is set to `100` that means the DNS server will not overwrite cached entries for the entire duration of the TTL. |                |
| **MaxKBSize**                        | Write     | `[System.UInt32]`  | Specifies the maximum size, in kilobytes, of the memory cache of a DNS server. If set to `0` there is no limit.                                                                                                                                                                                                                                                                                                                      |                |
| **MaxNegativeTtl**                   | Write     | `[System.String]`  | Specifies how long an entry that records a negative answer to a query remains stored in the DNS cache. Minimum value is `'00:00:01'` and maximum value is `'30.00:00:00'`                                                                                                                                                                                                                                                            |                |
| **MaxTtl**                           | Write     | `[System.String]`  | Specifies how long a record is saved in cache. Minimum value is `'00:00:00'` and maximum value is `'30.00:00:00'`. If the TimeSpan is set to `'00:00:00'` (0 seconds), the DNS server does not cache records.                                                                                                                                                                                                                        |                |
| **EnablePollutionProtection**        | Write     | `[System.Boolean]` | [See Additional Information for EnablePollutionProtection](####additional-information-for-enablepollutionprotection)                                                                                                                                                                                                                                                                                                                                               |                |
| **StoreEmptyAuthenticationResponse** | Write     | `[System.Boolean]` | Specifies whether a DNS server stores empty authoritative responses in the cache (RFC-2308).                                                                                                                                                                                                                                                                                                                                         |                |

---

#### Additional Information for **EnablePollutionProtection**

Specifies whether DNS filters name service (NS) resource records that are cached. Valid values are False (`$false`), which caches all responses to name queries; and True (`$true`), which caches only the records that belong to the same DNS subtree.

When you set this parameter value to False (`$false`):

- Cache pollution protection is disabled
- A DNS server caches the Host (A) record and all queried NS resources that are in the DNS server zone.
- In this case, DNS can also cache the NS record of an unauthorized DNS server.
- This event causes name resolution to fail or to be appropriated for subsequent queries in the specified domain.

When you set the value for this parameter to True (`$true`):

- The DNS server enables cache pollution protection and ignores the Host (A) record.
- The DNS server performs a cache update query to resolve the address of the NS if the NS is outside the zone of the DNS server.
- The additional query minimally affects DNS server performance.

---

<br />

## Example `DnsServerCacheSettings`

```yaml
DnsServerCacheSettings:
    LockingPercent: 100
    MaxKBSize: 0
    MaxNegativeTtl: "00:15:00"
    MaxTtl: "1.00:00:00"
    EnablePollutionProtection: true
    StoreEmptyAuthenticationResponse: true

```

<br />

## Lookup Options in `Datum.yml`

```yaml
lookup_options:

  DnsServerCacheSettings:
  	merge_hash: deep
```

<br />

[DnsServerDsc]: https://github.com/dsccommunity/DnsServerDsc
[PSDesiredStateConfiguration]: https://docs.microsoft.com/en-us/powershell/module/psdesiredstateconfiguration/about/about_classes_and_dsc?view=powershell-7.1
[DnsServerCache]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerCache
[WindowsFeature]: https://docs.microsoft.com/en-us/powershell/scripting/dsc/reference/resources/windows/windowsfeatureresource?view=powershell-7.2