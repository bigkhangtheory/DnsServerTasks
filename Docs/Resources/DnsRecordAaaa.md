# DnsRecordAaaa

## Parameters

| Parameter       | Attribute  | DataType   | Description                                                                                                                                                        | Allowed Values |
| --------------- | ---------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------- |
| **ZoneName**    | *Required* | `[String]` | Specifies the name of a DNS zone. (Key Parameter)                                                                                                                  |                |
| **TimeToLive**  |            | `[String]` | Specifies the TimeToLive value of the SRV record. Value must be in valid TimeSpan string format (i.e.: Days.Hours:Minutes:Seconds.Miliseconds or 30.23:59:59.999). |                |
| **Ensure**      |            | `[String]` | Whether the host record should be present or removed.                                                                                                              |                |
| **Name**        | *Required* | `[String]` | Specifies the name of a DNS server resource record object. (Key Parameter)                                                                                         |                |
| **IPv6Address** | *Required* | `[String]` | Specifies the IPv6 address of a host. (Key Parameter)                                                                                                              |                |

## Description

The DnsRecordAaaa DSC resource manages AAAA DNS records against a specific zone on a Domain Name System (DNS) server.

## Examples

### Example 1

This configuration will ensure a DNS AAAA record exists when only the mandatory properties are specified.

```powershell
Configuration DnsRecordAaaa_Mandatory_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsRecordAaaa 'TestRecord'
        {
            ZoneName    = 'contoso.com'
            Name        = 'www'
            IPv6Address = '2001:db8:85a3::8a2e:370:7334'
            Ensure      = 'Present'
        }
    }
}
```

### Example 2

This configuration will ensure a DNS AAAA record exists when all properties are specified.

```powershell
Configuration DnsRecordAaaa_Full_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsRecordAaaa 'TestRecord'
        {
            ZoneName    = 'contoso.com'
            Name        = 'www'
            IPv6Address = '2001:db8:85a3::8a2e:370:7334'
            TimeToLive  = '01:00:00'
            DnsServer   = 'localhost'
            Ensure      = 'Present'
        }
    }
}
```

### Example 3

This configuration will ensure a DNS AAAA record does not exist when mandatory properties are specified.

Note that not all mandatory properties are necessarily key properties. Non-key property values will be ignored when determining whether the record is to be removed.

```powershell
Configuration DnsRecordAaaa_Remove_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsRecordAaaa 'TestRecord'
        {
            ZoneName    = 'contoso.com'
            Name        = 'www'
            IPv6Address = '2001:db8:85a3::8a2e:370:7334'
            Ensure      = 'Absent'
        }
    }
}
```
