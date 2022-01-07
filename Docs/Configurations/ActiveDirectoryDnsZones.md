# ActiveDirectoryDnsZones

The **ActiveDirectoryDnsZones** DSC configuration manages DNS Active Directory primary zones on a Microsoft Domain Name System (DNS).

<br />

## Project Information

|                  |                                                                                                                                      |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| **Source**       | https://prod1gitlab.mapcom.local/dsc/configurations/DnsServerTasks/-/tree/master/DnsServerTasks/DscResources/ActiveDirectoryDnsZones |
| **Dependencies** | [DnsServerDsc][DnsServerDsc], [PSDesiredStateConfiguration][PSDesiredStateConfiguration], [Indented.Net.IP][Indented.Net.IP]         |
| **Resources**    | [DnsServerADZone][DnsServerADZone], [WindowsFeature][WindowsFeature]                                                                 |

<br />

## Parameters

<br />

### Table. Attributes of `ActiveDirectoryDnsZones`

| Parameter              | Attribute  | DataType        | Description                                                                                                            | Allowed Values                         |
| :--------------------- | :--------- | :-------------- | :--------------------------------------------------------------------------------------------------------------------- | :------------------------------------- |
| **ComputerName**       | *Optional* | `[String]`      | Specifies a DNS server. If you do not specify this parameter, the command runs on the local system.                    |                                        |
| **Credential**         | *Optional* | `[String]`      | Specifies the credential to when creating the DNS zone. Only used when passing a value for the ComputerName parameter. |                                        |
| **DynamicUpdate**      | *Optional* | `[String]`      | AD zone dynamic DNS update option. Defaults to `'NonSecureAndSecure'`.                                                 | `None`, `NonSecureAndSecure`, `Secure` |
| **ForwardLookupZones** |            | `[Hashtable[]]` | Specify a list of DNS forward lookup zones.                                                                            |                                        |
| **ReverseLookupZones** |            | `[Hashtable[]]` | Specifies a list of IPv4 subnets to create DNS reverse lookup zones.                                                   |                                        |

---

<br />

#### Table. Attributes of `ForwardLookupZones`

| Parameter     | Attribute  | DataType     | Description                                               | Allowed Values                         |
| :------------ | :--------- | ------------ | :-------------------------------------------------------- | :------------------------------------- |
| **Scope**     | *Required* | `[String]`   | AD zone replication scope option.                         | `Custom`, `Domain`, `Forest`, `Legacy` |
| **ZoneNames** | *Required* | `[String[]]` | Specify a list of AD DNS zones for the replication scope. |                                        |

---

<br />


#### Table. Attributes of `ReserveLookupZones`

| Parameter   | Attribute  | DataType     | Description                                                        | Allowed Values                         |
| :---------- | :--------- | ------------ | :----------------------------------------------------------------- | :------------------------------------- |
| **Scope**   | *Required* | `[String]`   | AD zone replication scope option.                                  | `Custom`, `Domain`, `Forest`, `Legacy` |
| **Subnets** | *Required* | `[String[]]` | Specify a list of IP Subnet ranges to create Reverse Lookup Zones. |                                        |

> `Subnets`: The key value can be prefixed with `+` and `-` to ensure whether the Reverse Lookup Zones for the subnet should be `Present` or `Absent` respectively.
{.is-info}

---

## Example *ActiveDirectoryDnsZones*

```yaml
ActiveDirectoryDnsZones:
  DynamicUpdate: NonSecureAndSecure
  ForwardLookupZones:
    - Scope: Legacy
      ZoneNames:
        - mapcom.local
        - admin.internal
        - dchoice.local
        - dev.db
        - dev.internal
        - dev1.db
        - dev3.db
        - internal

    - Scope: Domain
      ZoneNames:
        - cm.lab
        - comsol-pic.com
        - client4.signius.com
        - cs.signius.com

  ReverseLookupZones:
    - Scope: Legacy
      Subnets:
          # CM LAB
        - 172.16.96.0/20
          # Legacy Chesapeake - Server
        - 172.16.0.0/20
          # Legacy Chesapeake - Back Office
        - -172.16.16.0/20
          # Legacy Remote Site - Mobile
        - -172.18.19.0/24

    - Scope: Domain
      Subnets:
          # NAS VRF
        - 10.51.0.0/16
          # Windows VRF
        - 10.101.0.0/16
          # Management VRF
        - 10.160.0.0/16
          # Private VRF
        - 10.170.0.0/16
          # Public VRF
        - 10.180.0.0/16
          # DEVNET
        - 10.190.0.0/16
          # Headquarters - Chesapeake
        - 10.200.0.0/20
          # Remote Site - Nashville
        - 10.200.16.0/20
          # Remote Site - Signius
        - 10.200.224.0/20
          # CM VRF
        - 10.254.0.0/16
```

<br />

## Lookup Options in `Datum.yml`

```yaml
lookup_options:

  ActiveDirectoryDnsZones:
    merge_hash: deep
  ActiveDirectoryDnsZones\ForwardLookupZones:
    merge_hash_array: UniqueKeyValTuples
    merge_options:
      tuple_keys:
        - Scope
  ActiveDirectoryDnsZones\ForwardLookupZones\ZoneNames:
    merge_baseType_array: Unique
  ActiveDirectoryDnsZones\ReverseLookupZones:
    merge_hash_array: UniqueKeyValTuples
    merge_options:
      tuple_keys:
        - Scope
  ActiveDirectoryDnsZones\ForwardLookupZones\Subnets:
    merge_baseType_array: Unique

```

[DnsServerDsc]: https://github.com/dsccommunity/DnsServerDsc
[PSDesiredStateConfiguration]: https://docs.microsoft.com/en-us/powershell/module/psdesiredstateconfiguration/?view=powershell-7.1
[Indented.Net.IP]: https://github.com/indented-automation/Indented.Net.IP
[DnsServerADZone]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerADZone
[WindowsFeature]: https://docs.microsoft.com/en-us/powershell/scripting/dsc/reference/resources/windows/windowsfeatureresource?view=powershell-7.2