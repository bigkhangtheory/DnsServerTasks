# DnsRecordMxScoped

## Parameters

| Parameter        | Attribute  | DataType      | Description                                                                                                                                                                                                                   | Allowed Values |
| ---------------- | ---------- | ------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| **EmailDomain**  | *Required* | `[String]`    | Everything after the '@' in the email addresses supported by this mail exchanger. It must be a subdomain the zone or the zone itself. To specify all subdomains, use the '*' character (i.e.: *.contoso.com). (Key Parameter) |                |
| **MailExchange** | *Required* | `[String]`    | FQDN of the server handling email for the specified email domain. When setting the value, this FQDN must resolve to an IP address and cannot reference a CNAME record. (Key Parameter)                                        |                |
| **Priority**     | Required   | System.UInt16 | Specifies the priority for this MX record among other MX records that belong to the same email domain, where a lower value has a higher priority. (Mandatory Parameter)                                                       |                |
| **ZoneScope**    | *Required* | `[String]`    | Specifies the name of a zone scope. (Key Parameter)                                                                                                                                                                           |                |

## Description

The DnsRecordMxScoped DSC resource manages MX DNS records against a specific zone and zone scope on a Domain Name System (DNS) server.

## Examples

### Example 1

This configuration will ensure a DNS MX record exists when only the mandatory properties are specified.

```powershell
Configuration DnsRecordMxScoped_Mandatory_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsRecordMxScoped 'TestRecord'
        {
            ZoneName     = 'contoso.com'
            ZoneScope    = 'external'
            EmailDomain  = 'contoso.com'
            MailExchange = 'mailserver1.contoso.com'
            Priority     = 20
            Ensure       = 'Present'
        }
    }
}
```

### Example 2

This configuration will ensure a DNS MX record exists when all properties are specified.

```powershell
Configuration DnsRecordMxScoped_Full_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsRecordMxScoped 'TestRecord'
        {
            ZoneName     = 'contoso.com'
            ZoneScope    = 'external'
            EmailDomain  = 'contoso.com'
            MailExchange = 'mailserver1.contoso.com'
            Priority     = 20
            TimeToLive   = '01:00:00'
            DnsServer    = 'localhost'
            Ensure       = 'Present'
        }
    }
}
```

### Example 3

This configuration will ensure a DNS MX record does not exist when mandatory properties are specified.

Note that the 'Priority' property value will be ignored when determining whether the record is to be removed.

```powershell
Configuration DnsRecordMxScoped_Remove_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsRecordMxScoped 'TestRecord'
        {
            ZoneName     = 'contoso.com'
            ZoneScope    = 'external'
            EmailDomain  = 'contoso.com'
            MailExchange = 'mailserver1.contoso.com'
            Priority     = 20
            Ensure       = 'Absent'
        }
    }
}
```
