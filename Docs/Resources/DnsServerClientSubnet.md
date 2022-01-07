# DnsServerClientSubnet

## Parameters

| Parameter      | Attribute  | DataType     | Description                                                                    | Allowed Values      |
| -------------- | ---------- | ------------ | ------------------------------------------------------------------------------ | ------------------- |
| **Name**       | *Required* | `[String]`   | Specifies the name of the client subnet.                                       |                     |
| **IPv4Subnet** |            | `[String[]]` | Specify an array (1 or more values) of IPv4 Subnet addresses in CIDR Notation. |                     |
| **IPv6Subnet** |            | `[String[]]` | Specify an array (1 or more values) of IPv6 Subnet addresses in CIDR Notation. |                     |
| **Ensure**     |            | `[String]`   | Should this DNS server client subnet be present or absent                      | `Present`, `Absent` |

## Description

The DnsServerClientSubnet DSC resource manages DNS Client Subnets on a Domain Name System (DNS) server. A client subnet is a group of IP subnets that represent a logical group, for example, a geographical area, a datacenter, or a trusted resolver fleet. You can use client subnets in criteria in DNS policies. Multiple DNS policies can refer to the same client subnet.

## Requirements

- Target machine must be running Windows Server 2016 or later.

## Examples

### Example 1

This configuration will manage a DNS client subnet

```powershell
Configuration DnsServerClientSubnet_config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    Node localhost
    {
        DnsServerClientSubnet 'ClientSubnet1'
        {
            Name       = 'London'
            IPv4Subnet = @('10.1.0.0/16', '10.8.0.0/16')
            Ensure     = 'Present'
        }
    }
}
```

