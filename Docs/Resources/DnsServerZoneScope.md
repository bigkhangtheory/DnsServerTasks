# DnsServerZoneScope

## Parameters

| Parameter    | Attribute  | DataType   | Description                                            | Allowed Values      |
| ------------ | ---------- | ---------- | ------------------------------------------------------ | ------------------- |
| **Name**     | *Required* | `[String]` | Specifies the name of the Zone Scope.                  |                     |
| **ZoneName** | *Required* | `[String]` | Specify the existing DNS Zone to add a scope to.       |                     |
| **Ensure**   |            | `[String]` | Should this DNS Server Zone Scope be present or absent | `Present`, `Absent` |
| **ZoneFile** | Read       | `[String]` | Returns the zone scope filename.                       |                     |

## Description

The DnsServerZoneScope DSC resource manages the zone scope on an existing zone on the Domain Name System (DNS) server

The name of the scope should adhere to the same conventions as the zone name. The scope name cannot be same as the zone name to which it is attached.

## Requirements

- Target machine must be running Windows Server 2016 or later.

## Examples

### Example 1

This configuration will manage a DNS zone scope

```powershell
Configuration DnsServerZoneScope_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    DnsServerZoneScope 'ZoneScope1'
    {
        Name     = 'contoso_NorthAmerica'
        ZoneName = 'contoso.com'
        Ensure   = 'Present'
    }
}
```

