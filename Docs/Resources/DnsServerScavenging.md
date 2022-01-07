# DnsServerScavenging

## Parameters

| Parameter              | Attribute  | DataType                  | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | Allowed Values |
| ---------------------- | ---------- | ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| **DnsServer**          | *Required* | `[String]`                | The host name of the Domain Name System (DNS) server, or use 'localhost' for the current node.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |                |
| **ScavengingState**    |            | `[Boolean]`               | Specifies whether to Enable automatic scavenging of stale records. `ScavengingState` determines whether the DNS scavenging feature is enabled by default on newly created zones.                                                                                                                                                                                                                                                                                                                                                                                                                                  |                |
| **ScavengingInterval** |            | `[String]`                | Specifies a length of time as a value that can be converted to a `[TimeSpan]` object. `ScavengingInterval` determines whether the scavenging feature for the DNS server is enabled and sets the number of hours between scavenging cycles. The value `0` disables scavenging for the DNS server. A setting greater than `0` enables scavenging for the server and sets the number of days, hours, minutes, and seconds (formatted as dd.hh:mm:ss) between scavenging cycles. The minimum value is 0. The maximum value is 365.00:00:00 (1 year).                                                                  |                |
| **RefreshInterval**    |            | `[String]`                | Specifies the refresh interval as a value that can be converted to a `[TimeSpan]` object (formatted as dd.hh:mm:ss). During this interval, a DNS server can refresh a resource record that has a non-zero time stamp. Zones on the server inherit this value automatically. If a DNS server does not refresh a resource record that has a non-zero time stamp, the DNS server can remove that record during the next scavenging. Do not select a value smaller than the longest refresh period of a resource record registered in the zone. The minimum value is `0`. The maximum value is 365.00:00:00 (1 year). |                |
| **NoRefreshInterval**  |            | `[String]`                | Specifies a length of time as a value that can be converted to a `[TimeSpan]` object (formatted as dd.hh:mm:ss). `NoRefreshInterval` sets a period of time in which no refreshes are accepted for dynamically updated records. Zones on the server inherit this value automatically. This value is the interval between the last update of a timestamp for a record and the earliest time when the timestamp can be refreshed. The minimum value is 0. The maximum value is 365.00:00:00 (1 year).                                                                                                                |                |
| **LastScavengeTime**   | Read       | Nullable[System.DateTime] | The time when the last scavenging cycle was executed.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |                |

## Description

The DnsServerScavenging DSC resource manages scavenging on a Microsoft
Domain Name System (DNS) server.

## Examples

### Example 1

This configuration will enable scavenging and change the scavenging intervals
on the DNS server.

```powershell
Configuration DnsServerScavenging_EnableAndChangeScavengingIntervals_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerScavenging 'EnableScavengingAndChangeIntervals'
        {
            DnsServer          = 'localhost'
            ScavengingState    = $true
            ScavengingInterval = '7.00:00:00'
            RefreshInterval    = '7.00:00:00'
            NoRefreshInterval  = '7.00:00:00'
        }
    }
}
```

### Example 2

This configuration will enable scavenging on the DNS server, using
the default interval values.

```powershell
Configuration DnsServerScavenging_EnableScavenging_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerScavenging 'EnableScavenging'
        {
            DnsServer       = 'localhost'
            ScavengingState = $true
        }
    }
}
```

### Example 3

This configuration will change scavenging intervals on the DNS server, but
does not enforce that scavenging is enabled.

```powershell
Configuration DnsServerScavenging_ChangeScavengingIntervals_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerScavenging 'ChangeScavengingIntervals'
        {
            DnsServer          = 'localhost'
            ScavengingInterval = '7.00:00:00'
            RefreshInterval    = '7.00:00:00'
            NoRefreshInterval  = '7.00:00:00'
        }
    }
}
```

### Example 4

This configuration will disable scavenging on the DNS server.

```powershell
Configuration DnsServerScavenging_DisableScavenging_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerScavenging 'DisableScavenging'
        {
            DnsServer       = 'localhost'
            ScavengingState = $false
        }
    }
}
```
