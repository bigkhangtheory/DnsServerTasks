# DnsServerForwarder

## Parameters

| Parameter            | Attribute  | DataType          | Description                                                                                                                                       | Allowed Values |
| -------------------- | ---------- | ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| **IsSingleInstance** | *Required* | `[String]`        | Specifies the resource is a single instance, the value must be `'Yes'`.                                                                           | `Yes`          |
| **IPAddresses**      |            | `[String[]]`      | IP addresses of the forwarders                                                                                                                    |                |
| **UseRootHint**      |            | `[Boolean]`       | Specifies if you want to use root hint or not.                                                                                                    |                |
| **EnableReordering** |            | `[Boolean]`       | Specifies whether to enable the DNS server to reorder forwarders dynamically.                                                                     |                |
| **Timeout**          |            | `[System.UInt32]` | Specifies the number of seconds that the DNS server waits for a response from the forwarder. The minimum value is 0, and the maximum value is 15. |                |

## Description

The DnsServerForwarder DSC resource manages the DNS forwarder list of a
Domain Name System (DNS) server. If the parameter `EnableReordering` is set
to `$false` then the preferred forwarder can be put in the series of forwarder
IP addresses.

## Examples

### Example 1

This configuration will set the DNS forwarders

```powershell
Configuration DnsServerForwarder_set_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {

        DnsServerForwarder 'SetForwarders'
        {
            IsSingleInstance = 'Yes'
            IPAddresses      = @('192.168.0.10', '192.168.0.11')
            UseRootHint      = $false
        }
    }
}
```

### Example 2

This configuration will remove all the DNS forwarders

```powershell
Configuration DnsServerForwarder_remove_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerForwarder 'SetForwarders'
        {
            IsSingleInstance = 'Yes'
            IPAddresses      = @()
            UseRootHint      = $false
        }
    }
}
```

### Example 3

This configuration will remove all the DNS forwarders

```powershell
Configuration DnsServerForwarder_SetUseRootHint_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerForwarder 'SetUseRootHints'
        {
            IsSingleInstance = 'Yes'
            UseRootHint      = $true
        }
    }
}
```

### Example 4

This configuration will set the DNS forwarders and enable dynamic reordering.

```powershell
Configuration DnsServerForwarder_EnableReordering_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerForwarder 'SetUseRootHints'
        {
            IsSingleInstance = 'Yes'
            IPAddresses      = @('192.168.0.10', '192.168.0.11')
            UseRootHint      = $false
            EnableReordering = $true
        }
    }
}
```

### Example 5

This configuration will set the DNS forwarders and disable dynamic reordering.

```powershell
Configuration DnsServerForwarder_DisableReordering_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerForwarder 'SetUseRootHints'
        {
            IsSingleInstance = 'Yes'
            IPAddresses      = @('192.168.0.10', '192.168.0.11')
            UseRootHint      = $false
            EnableReordering = $false
        }
    }
}
```

### Example 6

This configuration will set the DNS forwarders and disable dynamic reordering.

```powershell
Configuration DnsServerForwarder_SetTimeout_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerForwarder 'SetUseRootHints'
        {
            IsSingleInstance = 'Yes'
            IPAddresses      = @('192.168.0.10', '192.168.0.11')
            UseRootHint      = $false
            Timeout          = 10
        }
    }
}
```

