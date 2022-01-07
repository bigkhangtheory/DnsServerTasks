# DnsServerSecondaryZone

## Parameters

| Parameter         | Attribute  | DataType     | Description                                             | Allowed Values      |
| ----------------- | ---------- | ------------ | ------------------------------------------------------- | ------------------- |
| **Name**          | *Required* | `[String]`   | Name of the secondary zone                              |                     |
| **MasterServers** | Required   | `[String[]]` | IP address or DNS name of the secondary DNS servers     |                     |
| **Ensure**        |            | `[String]`   | Whether the secondary zone should be present or absent. | `Present`, `Absent` |
| **Type**          | Read       | `[String]`   | Type of the DNS server zone                             |                     |

## Description

The DnsServerSecondaryZone DSC resource manages a standalone file-backed
secondary zone on a Domain Name System (DNS) server. Secondary zones allow
client machine in primary DNS zones to do DNS resolution of machines in the
secondary DNS zone.

## Examples

### Example 1

This configuration will manage a secondary standalone DNS zone

```powershell
Configuration DnsServerSecondaryZone_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerSecondaryZone 'sec'
        {
            Ensure        = 'Present'
            Name          = 'demo.contoso.com'
            MasterServers = '192.168.10.2'
        }
    }
}
```

