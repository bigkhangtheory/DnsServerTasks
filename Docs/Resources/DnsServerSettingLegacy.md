# DnsServerSettingLegacy

## Parameters

| Parameter                | Attribute  | DataType          | Description                                                                                                           | Allowed Values |
| ------------------------ | ---------- | ----------------- | --------------------------------------------------------------------------------------------------------------------- | -------------- |
| **DnsServer**            | *Required* | `[String]`        | Specifies the DNS server to connect to, or use 'localhost' for the current node.                                      |                |
| **DisjointNets**         |            | `[Boolean]`       | Indicates whether the default port binding for a socket used to send queries to remote DNS Servers can be overridden. |                |
| **NoForwarderRecursion** |            | `[Boolean]`       | TRUE if the DNS server does not use recursion when name-resolution through forwarders fails.                          |                |
| **LogLevel**             |            | `[System.UInt32]` | Indicates which policies are activated in the Event Viewer system log.                                                |                |

## Description

The DnsServerSettingLegacy DSC resource manages the Domain Name System (DNS) server
legacy settings.

If the parameter **DnsServer** is set to `'localhost'` then the resource
can normally use the default credentials (SYSTEM) to configure the DNS server
settings. If using any other value for the parameter **DnsServer** make sure
that the credential the resource is run as have the correct permissions
at the target node and the necessary network traffic is permitted (_WsMan_
protocol). It is possible to run the resource with specific credentials using the
built-in parameter **PsDscRunAsCredential**.

## Examples

### Example 1

This configuration will manage the DNS server legacy settings on the current
node.

```powershell
Configuration DnsServerSettingLegacy_CurrentNode_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerSettingLegacy 'DnsServerLegacyProperties'
        {
            DnsServer            = 'localhost'
            DisjointNets         = $false
            NoForwarderRecursion = $true
            LogLevel             = 50393905
        }
    }
}
```

### Example 2

This configuration will manage the DNS server legacy settings on the current
node.

```powershell
Configuration DnsServerSettingLegacy_RemoteNode_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerSettingLegacy 'DnsServerLegacyProperties'
        {
            DnsServer            = 'dns1.company.local'
            DisjointNets         = $false
            NoForwarderRecursion = $true
            LogLevel             = 50393905
        }
    }
}
```

