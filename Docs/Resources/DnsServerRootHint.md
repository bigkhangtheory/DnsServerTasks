# DnsServerRootHint

## Parameters

| Parameter            | Attribute  | DataType            | Description                                                              | Allowed Values |
| -------------------- | ---------- | ------------------- | ------------------------------------------------------------------------ | -------------- |
| **IsSingleInstance** | *Required* | `[String]`          | Specifies the resource is a single instance, the value must be `'Yes'`.  | `Yes`          |
| **NameServer**       | Required   | MSFT_KeyValuePair[] | A hashtable that defines the name server. Key and value must be strings. |                |

## Description

The DnsServerRootHint DSC resource manages root hints on a Domain Name System (DNS) server.

## Examples

### Example 1

This configuration will manage the DNS server root hints

```powershell
Configuration DnsServerRootHint_set_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerRootHint 'RootHints'
        {
            IsSingleInstance = 'Yes'
            NameServer       = @{
                'A.ROOT-SERVERS.NET.' = '2001:503:ba3e::2:30'
                'B.ROOT-SERVERS.NET.' = '2001:500:84::b'
                'C.ROOT-SERVERS.NET.' = '2001:500:2::c'
                'D.ROOT-SERVERS.NET.' = '2001:500:2d::d'
                'E.ROOT-SERVERS.NET.' = '192.203.230.10'
                'F.ROOT-SERVERS.NET.' = '2001:500:2f::f'
                'G.ROOT-SERVERS.NET.' = '192.112.36.4'
                'H.ROOT-SERVERS.NET.' = '2001:500:1::53'
                'I.ROOT-SERVERS.NET.' = '2001:7fe::53'
                'J.ROOT-SERVERS.NET.' = '2001:503:c27::2:30'
                'K.ROOT-SERVERS.NET.' = '2001:7fd::1'
                'L.ROOT-SERVERS.NET.' = '2001:500:9f::42'
                'M.ROOT-SERVERS.NET.' = '2001:dc3::353'
            }
        }
    }
}
```

### Example 2

This configuration will remove the DNS server root hints

```powershell
Configuration DnsServerRootHint_remove_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerRootHint 'RootHints'
        {
            IsSingleInstance = 'Yes'
            NameServer       = @{ }
        }
    }
}
```

