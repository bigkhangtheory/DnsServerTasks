# DnsRecordA

## Parameters

| Parameter       | Attribute  | DataType   | Description                                                                                                                                                        | Allowed Values |
| --------------- | ---------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------- |
| **ZoneName**    | *Required* | `[String]` | Specifies the name of a DNS zone. (Key Parameter)                                                                                                                  |                |
| **TimeToLive**  |            | `[String]` | Specifies the TimeToLive value of the SRV record. Value must be in valid TimeSpan string format (i.e.: Days.Hours:Minutes:Seconds.Miliseconds or 30.23:59:59.999). |                |
| **Ensure**      |            | `[String]` | Whether the host record should be present or removed.                                                                                                              |                |
| **Name**        | *Required* | `[String]` | Specifies the name of a DNS server resource record object. (Key Parameter)                                                                                         |                |
| **IPv4Address** | *Required* | `[String]` | Specifies the IPv4 address of a host. (Key Parameter)                                                                                                              |                |

## Description

The DnsRecordA DSC resource manages A DNS records against a specific zone on a Domain Name System (DNS) server.

## Examples

### Example 1

This configuration will ensure a DNS A record exists when only the mandatory properties are specified.

```powershell
Configuration DnsRecordA_Mandatory_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsRecordA 'TestRecord'
        {
            ZoneName    = 'contoso.com'
            Name        = 'www'
            IPv4Address = '192.168.50.10'
            Ensure      = 'Present'
        }
    }
}
```

### Example 2

This configuration will ensure a DNS A record exists when all properties are specified.

```powershell
Configuration DnsRecordA_Full_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsRecordA 'TestRecord'
        {
            ZoneName    = 'contoso.com'
            Name        = 'www'
            IPv4Address = '192.168.50.10'
            TimeToLive  = '01:00:00'
            DnsServer   = 'localhost'
            Ensure      = 'Present'
        }
    }
}
```

### Example 3

This configuration will ensure a DNS A record does not exist when mandatory properties are specified.

Note that not all mandatory properties are necessarily key properties. Non-key property values will be ignored when determining whether the record is to be removed.

```powershell
Configuration DnsRecordA_Remove_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsRecordA 'TestRecord'
        {
            ZoneName    = 'contoso.com'
            Name        = 'www'
            IPv4Address = '192.168.50.10'
            Ensure      = 'Absent'
        }
    }
}
```
