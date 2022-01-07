# DnsRecordPtr

## Parameters

| Parameter      | Attribute  | DataType   | Description                                                                                                                                                        | Allowed Values |
| -------------- | ---------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------- |
| **ZoneName**   | *Required* | `[String]` | Specifies the name of a DNS zone. (Key Parameter)                                                                                                                  |                |
| **TimeToLive** |            | `[String]` | Specifies the TimeToLive value of the SRV record. Value must be in valid TimeSpan string format (i.e.: Days.Hours:Minutes:Seconds.Miliseconds or 30.23:59:59.999). |                |
| **Ensure**     |            | `[String]` | Whether the host record should be present or removed.                                                                                                              |                |
| **IpAddress**  | *Required* | `[String]` | Specifies the IP address to which the record is associated (Can be either IPv4 or IPv6. (Key Parameter)                                                            |                |
| **Name**       | *Required* | `[String]` | Specifies the FQDN of the host when you add a PTR resource record. (Key Parameter)                                                                                 |                |

## Description

The DnsRecordPtr DSC resource manages PTR DNS records against a specific zone on a Domain Name System (DNS) server.

## Examples

### Example 1

This configuration will ensure a DNS PTR record exists when only the mandatory properties are specified.

```powershell
Configuration DnsRecordPtr_Mandatory_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsRecordPtr 'TestRecord'
        {
            ZoneName  = '0.168.192.in-addr.arpa'
            IpAddress = '192.168.0.9'
            Name      = 'quarks.contoso.com'
            Ensure    = 'Present'
        }
    }
}
```

### Example 2

This configuration will ensure a DNS PTR record exists when all properties are specified.

```powershell
Configuration DnsRecordPtr_Full_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsRecordPtr 'TestRecord'
        {
            ZoneName  = '0.168.192.in-addr.arpa'
            IpAddress = '192.168.0.9'
            Name      = 'quarks.contoso.com'
            TimeToLive = '01:00:00'
            DnsServer = 'localhost'
            Ensure    = 'Present'
        }
    }
}
```

### Example 3

This configuration will ensure a DNS PTR record does not exist when mandatory properties are specified.

```powershell
Configuration DnsRecordPtr_Remove_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsRecordPtr 'TestRecord'
        {
            ZoneName  = '0.168.192.in-addr.arpa'
            IpAddress = '192.168.0.9'
            Name      = 'quarks.contoso.com'
            Ensure    = 'Absent'
        }
    }
}
```

### Example 4

This configuration will ensure a DNS PTR record exists for an IPv6 address when only the mandatory properties are specified.

```powershell
Configuration DnsRecordPtr_Mandatory_v6_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsRecordPtr 'TestRecord'
        {
            ZoneName  = '0.0.d.f.ip6.arpa'
            IpAddress = 'fd00::515c:0:0:d59'
            Name      = 'quarks.contoso.com'
            Ensure    = 'Present'
        }
    }
}
```

### Example 5

This configuration will ensure a DNS PTR record exists for an IPv6 address when all properties are specified.

```powershell
Configuration DnsRecordPtr_Full_v6_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsRecordPtr 'TestRecord'
        {
            ZoneName  = '0.0.d.f.ip6.arpa'
            IpAddress = 'fd00::515c:0:0:d59'
            Name      = 'quarks.contoso.com'
            TimeToLive = '01:00:00'
            DnsServer = 'localhost'
            Ensure    = 'Present'
        }
    }
}
```

### Example 6

This configuration will ensure a DNS PTR record does not exist for an IPv6 address when mandatory properties are specified.

```powershell
Configuration DnsRecordPtr_Remove_v6_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsRecordPtr 'TestRecord'
        {
            ZoneName  = '0.0.d.f.ip6.arpa'
            IpAddress = 'fd00::515c:0:0:d59'
            Name      = 'quarks.contoso.com'
            Ensure    = 'Absent'
        }
    }
}
```
