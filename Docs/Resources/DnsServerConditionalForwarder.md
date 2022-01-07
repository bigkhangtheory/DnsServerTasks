# DnsServerConditionalForwarder

## Parameters

| Parameter                  | Attribute  | DataType     | Description                                                                                                                               | Allowed Values                                 |
| -------------------------- | ---------- | ------------ | ----------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------- |
| **Ensure**                 |            | `[String]`   | Specify whether the Conditional Forwarder is absent or present.                                                                           | `Present`, `Absent`                            |
| **Name**                   | *Required* | `[String]`   | The name of the zone to manage.                                                                                                           |                                                |
| **MasterServers**          |            | `[String[]]` | The IP addresses the forwarder should use. Mandatory if Ensure is present.                                                                |                                                |
| **ReplicationScope**       |            | `[String]`   | Whether the conditional forwarder should be replicated in AD, and the scope of that replication. Default is `None`.                       | `None`, `Custom`, `Domain`, `Forest`, `Legacy` |
| **DirectoryPartitionName** |            | `[String]`   | The name of the directory partition to use when the ReplicationScope is `Custom`. This value is ignored for all other replication scopes. |                                                |
| **ZoneType**               | Read       | `[String]`   | The zone type                                                                                                                             |                                                |

## Description

The DnsServerConditionalForwarder DSC resource manages a conditional forwarder on a Domain Name System (DNS) server.

You can manage the master servers, forwarder time-out, recursion, recursion scope, and directory partition name for a conditional forwarder zone.

## Examples

### Example 1

This configuration will manage a DNS server conditional forwarder

```powershell
Configuration DnsServerConditionalForwarder_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerConditionalForwarder 'Forwarder1'
        {
            Name             = 'London'
            MasterServers    = @('10.0.1.10', '10.0.2.10')
            ReplicationScope = 'Forest'
            Ensure           = 'Present'
        }
    }
}
```

