# DnsServerZoneTransfer

## Parameters

| Parameter           | Attribute  | DataType     | Description                                                                     | Allowed Values                     |
| ------------------- | ---------- | ------------ | ------------------------------------------------------------------------------- | ---------------------------------- |
| **Name**            | *Required* | `[String]`   | Name of the DNS zone                                                            |                                    |
| **Type**            | Required   | `[String]`   | Type of transfer allowed                                                        | `None`, `Any`, `Named`, `Specific` |
| **SecondaryServer** |            | `[String[]]` | IP address or DNS name of DNS servers where zone information can be transferred |                                    |

## Description

The DnsServerZoneTransfer DSC resource manages the replication settings of DNS Server zone data between servers.

## Examples

### Example 1

This configuration will manage a DNS zone transfer

```powershell
Configuration DnsServerZoneTransfer_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    DnsServerZoneTransfer 'TransferToAnyServer'
    {
        Name = 'demo.contoso.com'
        Type = 'Any'
    }
}
```

