# DnsServerPrimaryZone

## Parameters

| Parameter         | Attribute  | DataType   | Description                                                                             | Allowed Values               |
| ----------------- | ---------- | ---------- | --------------------------------------------------------------------------------------- | ---------------------------- |
| **Name**          | *Required* | `[String]` | Name of the DNS Server primary zone                                                     |                              |
| **ZoneFile**      |            | `[String]` | Name of the DNS Server primary zone file. If not specified, defaults to 'ZoneName.dns'. |                              |
| **DynamicUpdate** |            | `[String]` | Primary zone dynamic DNS update option. Defaults to `'None'`.                           | `None`, `NonSecureAndSecure` |
| **Ensure**        |            | `[String]` | Whether the DNS zone should be present or absent                                        | `Present`, `Absent`          |

## Description

The DnsServerPrimaryZone DSC resource manages a standalone file-backed Primary zone on a given Domain Name System (DNS) server.

## Examples

### Example 1

This configuration will add a file-backed classful reverse primary zone
using the resource default parameter values.

```powershell
Configuration DnsServerPrimaryZone_AddClassfulReversePrimaryZone_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerPrimaryZone 'AddPrimaryZone'
        {
            Name = '1.168.192.in-addr.arpa'
        }
    }
}
```

### Example 2

This configuration will add a file-backed classless reverse primary zone
using the resource default parameter values.

```powershell
Configuration DnsServerPrimaryZone_AddClasslessReversePrimaryZone_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerPrimaryZone 'AddPrimaryZone'
        {
            Name = '64-26.100.168.192.in-addr.arpa'
        }
    }
}
```

### Example 3

This configuration will add a file-backed primary zone using the resource
default parameter values.

```powershell
Configuration DnsServerPrimaryZone_AddPrimaryZoneUsingDefaults_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerPrimaryZone 'AddPrimaryZone'
        {
            Name = 'demo.contoso.com'
        }
    }
}
```

### Example 4

This configuration will add a file-backed primary zone using the resource
default parameter values.

```powershell
Configuration DnsServerPrimaryZone_AddPrimaryZoneWithSpecificValues_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerPrimaryZone 'AddPrimaryZone'
        {
            Ensure        = 'Present'
            Name          = 'demo.contoso.com'
            ZoneFile      = 'demo.contoso.com.dns'
            DynamicUpdate = 'NonSecureAndSecure'
        }
    }
}
```

### Example 5

This configuration will remove a file-backed primary zone.

```powershell
Configuration DnsServerPrimaryZone_RemovePrimaryZone_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerPrimaryZone 'RemovePrimaryZone'
        {
            Ensure        = 'Absent'
            Name          = 'demo.contoso.com'
        }
    }
}
```

### Example 6

This configuration will remove a file-backed primary zone.

```powershell
Configuration DnsServerPrimaryZone_RemoveReversePrimaryZone_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerPrimaryZone 'RemovePrimaryZone'
        {
            Ensure        = 'Absent'
            Name          = '1.168.192.in-addr.arpa'
        }
    }
}
```

