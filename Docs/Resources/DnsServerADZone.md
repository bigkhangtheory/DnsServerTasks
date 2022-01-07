# DnsServerADZone

## Parameters

| Parameter            | Attribute  | DataType   | Description                                                | Allowed Values                         |
| -------------------- | ---------- | ---------- | ---------------------------------------------------------- | -------------------------------------- |
| **Name**             | *Required* | `[String]` | Name of the AD DNS zone                                    |                                        |
| **DynamicUpdate**    |            | `[String]` | AD zone dynamic DNS update option. Defaults to `'Secure'`. | `None`, `NonSecureAndSecure`, `Secure` |
| **ReplicationScope** | Required   | `[String]` | AD zone replication scope option.                          | `Custom`, `Domain`, `Forest`, `Legacy` |
| **Ensure**           |            | `[String]` | Whether the DNS zone should be available or removed        | `Present`, `Absent`                    |

## Description

The DnsServerADZone DSC resource manages an AD integrated zone on a Domain Name System (DNS) server.

## Examples

### Example 1

This configuration will manage an AD integrated DNS forward lookup zone

```powershell
Configuration DnsServerADZone_forward_config
{
    param
    (
        [System.Management.Automation.PSCredential]
        $Credential
    )

    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {

        DnsServerADZone 'AddForwardADZone'
        {
            Name             = 'MyDomainName.com'
            DynamicUpdate    = 'Secure'
            ReplicationScope = 'Forest'
            ComputerName     = 'MyDnsServer.MyDomain.com'
            Credential       = $Credential
            Ensure           = 'Present'
        }
    }
}
```

### Example 2

This configuration will manage an AD integrated DNS reverse lookup zone

```powershell
Configuration DnsServerADZone_reverse_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerADZone 'addReverseADZone'
        {
            Name             = '1.168.192.in-addr.arpa'
            DynamicUpdate    = 'Secure'
            ReplicationScope = 'Forest'
            Ensure           = 'Present'
        }
    }
}
```

