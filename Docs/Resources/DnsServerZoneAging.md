# DnsServerZoneAging

## Parameters

| Parameter             | Attribute  | DataType          | Description                                                                         | Allowed Values |
| --------------------- | ---------- | ----------------- | ----------------------------------------------------------------------------------- | -------------- |
| **Name**              | *Required* | `[String]`        | Name of the DNS forward or reverse lookup zone.                                     |                |
| **Enabled**           | Required   | `[Boolean]`       | Option to enable scavenge stale resource records on the zone.                       |                |
| **RefreshInterval**   |            | `[System.UInt32]` | Refresh interval for record scavenging in hours. Default value is `168`, 7 days.    |                |
| **NoRefreshInterval** |            | `[System.UInt32]` | No-refresh interval for record scavenging in hours. Default value is `168`, 7 days. |                |

## Description

The DnsServerZoneAging DSC resource manages aging settings for a Domain Name System (DNS) server zone.

A resource record can remain on a DNS server after the resource is no longer part of the network. Aging settings determine when a record can be removed, or scavenged, as a stale record.

## Examples

### Example 1

This configuration will manage aging of a DNS forward zone

```powershell
Configuration DnsServerZoneAging_forward_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerZoneAging 'DnsServerZoneAging'
        {
            Name              = 'contoso.com'
            Enabled           = $true
            RefreshInterval   = 120   # 5 days
            NoRefreshInterval = 240   # 10 days
        }
    }
}
```

### Example 2

This configuration will manage aging of a DNS reverse zone

```powershell
Configuration DnsServerZoneAging_reverse_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerZoneAging 'DnsServerReverseZoneAging'
        {
            Name              = '168.192.in-addr-arpa'
            Enabled           = $true
            RefreshInterval   = 168   # 7 days
            NoRefreshInterval = 168   # 7 days
        }
    }
}
```

