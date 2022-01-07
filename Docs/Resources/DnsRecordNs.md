# DnsRecordNs

## Parameters

| Parameter      | Attribute  | DataType   | Description                                                                                                                                                                                                                          | Allowed Values |
| -------------- | ---------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------- |
| **ZoneName**   | *Required* | `[String]` | Specifies the name of a DNS zone. (Key Parameter)                                                                                                                                                                                    |                |
| **TimeToLive** |            | `[String]` | Specifies the TimeToLive value of the SRV record. Value must be in valid TimeSpan string format (i.e.: Days.Hours:Minutes:Seconds.Miliseconds or 30.23:59:59.999).                                                                   |                |
| **Ensure**     |            | `[String]` | Whether the host record should be present or removed.                                                                                                                                                                                |                |
| **DomainName** | *Required* | `[String]` | Specifies the fully qualified DNS domain name for which the NameServer is authoritative. It must be a subdomain the zone or the zone itself. To specify all subdomains, use the '*' character (i.e.: *.contoso.com). (Key Parameter) |                |
| **NameServer** | *Required* | `[String]` | Specifies the name server of a domain. This should be a fully qualified domain name, not an IP address (Key Parameter)                                                                                                               |                |

## Description

The DnsRecordNs DSC resource manages NS DNS records against a specific zone on a Domain Name System (DNS) server.

## Examples

### Example 1

This configuration will ensure a DNS NS record exists when only the mandatory properties are specified.

```powershell
Configuration DnsRecordNs_Mandatory_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsRecordNs 'TestRecord'
        {
            ZoneName   = 'contoso.com'
            DomainName = 'contoso.com'
            NameServer = 'ns.contoso.com'
            Ensure     = 'Present'
        }
    }
}
```

### Example 2

This configuration will ensure a DNS NS record exists when all properties are specified.

```powershell
Configuration DnsRecordNs_Full_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsRecordNs 'TestRecord'
        {
            ZoneName   = 'contoso.com'
            DomainName = 'contoso.com'
            NameServer = 'ns.contoso.com'
            TimeToLive = '01:00:00'
            DnsServer  = 'localhost'
            Ensure     = 'Present'
        }
    }
}
```

### Example 3

This configuration will ensure a DNS NS record does not exist when mandatory properties are specified.

Note that not all mandatory properties are necessarily key properties. Non-key property values will be ignored when determining whether the record is to be removed.

```powershell
Configuration DnsRecordNs_Remove_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsRecordNs 'TestRecord'
        {
            ZoneName   = 'contoso.com'
            DomainName = 'contoso.com'
            NameServer = 'ns.contoso.com'
            Ensure     = 'Absent'
        }
    }
}
```
