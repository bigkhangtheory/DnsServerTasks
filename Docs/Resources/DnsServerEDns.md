# DnsServerEDns

## Parameters

| Parameter           | Attribute  | DataType    | Description                                                                                           | Allowed Values |
| ------------------- | ---------- | ----------- | ----------------------------------------------------------------------------------------------------- | -------------- |
| **DnsServer**       | *Required* | `[String]`  | The host name of the Domain Name System (DNS) server, or use `'localhost'` for the current node.      |                |
| **CacheTimeout**    |            | `[String]`  | Specifies the number of seconds that the DNS server caches EDNS information.                          |                |
| **EnableProbes**    |            | `[Boolean]` | Specifies whether to enable the server to probe other servers to determine whether they support EDNS. |                |
| **EnableReception** |            | `[Boolean]` | Specifies whether the DNS server accepts queries that contain an EDNS record.                         |                |

## Description

The DnsServerEDns DSC resource manages _extension mechanisms for DNS (EDNS)_
on a Microsoft Domain Name System (DNS) server.

## Examples

### Example 1

This configuration will change the cache timeout for
extension mechanisms for DNS (EDNS) on the DNS server.

```powershell
Configuration DnsServerEDns_SetCacheTimeout_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerEDns 'SetCacheTimeout'
        {
            DnsServer    = 'localhost'
            CacheTimeout = '00:15:00'
        }
    }
}
```

### Example 2

This configuration will enable probes for the extension mechanisms for DNS
(EDNS) on the DNS server.

```powershell
Configuration DnsServerEDns_EnableProbes_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerEDns 'EnableProbes'
        {
            DnsServer    = 'localhost'
            EnableProbes = $true
        }
    }
}
```

### Example 3

This configuration will allow to accepts queries for the extension mechanisms
for DNS (EDNS) on the DNS server.

```powershell
Configuration DnsServerEDns_EnableReception_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerEDns 'EnableReception'
        {
            DnsServer       = 'localhost'
            EnableReception = $true
        }
    }
}
```
