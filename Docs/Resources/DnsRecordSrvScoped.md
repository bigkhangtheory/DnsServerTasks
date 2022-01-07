# DnsRecordSrvScoped

## Parameters

| Parameter        | Attribute  | DataType      | Description                                                           | Allowed Values |
| ---------------- | ---------- | ------------- | --------------------------------------------------------------------- | -------------- |
| **SymbolicName** | *Required* | `[String]`    | Service name for the SRV record. eg: xmpp, ldap, etc. (Key Parameter) |                |
| **Protocol**     | *Required* | `[String]`    | Service transmission protocol ('TCP' or 'UDP') (Key Parameter)        | `TCP`, `UDP`   |
| **Port**         | *Required* | System.UInt16 | The TCP or UDP port on which the service is found (Key Parameter)     |                |
| **Target**       | *Required* | `[String]`    | Specifies the Target Hostname or IP Address. (Key Parameter)          |                |
| **Priority**     | Required   | System.UInt16 | Specifies the Priority value of the SRV record. (Mandatory Parameter) |                |
| **Weight**       | Required   | System.UInt16 | Specifies the weight of the SRV record. (Mandatory Parameter)         |                |
| **ZoneScope**    | *Required* | `[String]`    | Specifies the name of a zone scope. (Key Parameter)                   |                |

## Description

The DnsRecordSrvScoped DSC resource manages SRV DNS records against a specific zone and zone scope on a Domain Name System (DNS) server.

## Examples

### Example 1

This configuration will ensure a DNS SRV record exists
in the external scope for XMPP that points to
chat.contoso.com with a priority of 10, weight of 20.

```powershell
Configuration DnsRecordSrvScoped_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsRecordSrvScoped 'TestRecord'
        {
            ZoneName     = 'contoso.com'
            ZoneScope    = 'external'
            SymbolicName = 'xmpp'
            Protocol     = 'tcp'
            Port         = 5222
            Target       = 'chat.contoso.com'
            Priority     = 10
            Weight       = 20
            Ensure       = 'Present'
        }
    }
}
```

### Example 2

This configuration will ensure a DNS SRV record exists in the
external scope for XMPP that points to chat.contoso.com with
a priority of 20, weight of 50 and Time To Live of 5 hours.

```powershell
Configuration DnsRecordSrvScoped_full_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsRecordSrvScoped 'TestRecord Full'
        {
            ZoneName     = 'contoso.com'
            ZoneScope    = 'external'
            SymbolicName = 'xmpp'
            Protocol     = 'tcp'
            Port         = 5222
            Target       = 'chat.contoso.com'
            Priority     = 20
            Weight       = 50
            TimeToLive   = '05:00:00'
            Ensure       = 'Present'
        }
    }
}
```

### Example 3

This configuration will remove a specified DNS SRV record in the
external scope. Note that Priority and Weight are mandatory
attributes, but their values are not used to determine which
record to remove.

```powershell
Configuration DnsRecordSrvScoped_Remove_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsRecordSrvScoped 'RemoveTestRecord'
        {
            ZoneName     = 'contoso.com'
            ZoneScope    = 'external'
            SymbolicName = 'xmpp'
            Protocol     = 'tcp'
            Port         = 5222
            Target       = 'chat.contoso.com'
            Priority     = 0
            Weight       = 0
            Ensure       = 'Absent'
        }
    }
}
```
