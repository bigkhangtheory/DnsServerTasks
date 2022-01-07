# DnsServerQueryResolutionPolicies

The **DnsServerQueryResolutionPolicies** manages settings of policies for query resolution on a Domain Name System (DNS) server.

<br />

## Project Information

|                  |                                                                                                                                                                                                                                                                                          |
| ---------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Source**       | https://github.com/bigkhangtheory/DnsServerTasks/tree/master/DnsServerTasks/DscResources/DnsServerQueryResolutionPolicies                                                                                                                                                                |
| **Dependencies** | [Add-DnsServerQueryResolutionPolicy][Add-DnsServerQueryResolutionPolicy], [Get-DnsServerQueryResolutionPolicy][Get-DnsServerQueryResolutionPolicy], [Set-DnsServerQueryResolutionPolicy][Set-DnsServerQueryResolutionPolicy], [PSDesiredStateConfiguration][PSDesiredStateConfiguration] |
| **Resources**    | [Script][Script]                                                                                                                                                                                                                                                                         |

<br />

## Parameters

<br />

### Table. Attributes of `DnsServerQueryResolutionPolicies`

| Parameter    | Attribute | DataType        | Description                                                                     | Allowed Values |
| :----------- | :-------- | :-------------- | :------------------------------------------------------------------------------ | :------------- |
| **Policies** |           | `[Hashtable[]]` | Settings of policies for query resolution on a Domain Name System (DNS) server. |                |

---

#### Table. Attributes of `Policies`

| Parameter  | Attribute  | DataType   | Description                                                                                                                                                                    | Allowed Values                    |
| :--------- | :--------- | :--------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------------------------------- |
| **Name**   | *Required* | `[String]` | Specifies a name for the new policy.                                                                                                                                           |                                   |
| **Action** | *Required* | `[String]` | Specifies the action to take if a query matches this policy.                                                                                                                   | `ALLOW`, `DENY`, `IGNORE`         |
| **Fqdn**   | *Required* | `[String]` | Specifies the FQDN criterion. This is the FQDN of record in the query. Specify a criterion in the following format: `[operator], val1, val2, ...; [operator], val3, val4, ...` | Valid `[operators]`: `EQ` or `NE` |

---

<br />

## Example `DnsServerQueryResolutionPolicies`

```yaml
DnsServerQueryResolutionPolicies:
  Policies:
    - Name:   WhitelistPolicy
      Action: IGNORE
      Fqdn:   NE,*.contoso.com
    - Name:   Block_Telemetry
      Action: IGNORE
      Fqdn:   EQ,telemetry.google.com

```

<br />

## Lookup Options in `Datum.yml`

```yaml
lookup_options:

  DnsServerQueryResolutionPolicies:
    merge_hash: deep
  DnsServerQueryResolutionPolicies\Policies:
    merge_hash_array: UniqueKeyValTuples
    merge_options:
      tuple_keys:
        - Name
        - Action
        - Fqdn

```

<br />

[DnsServerDsc]: https://github.com/dsccommunity/DnsServerDsc
[PSDesiredStateConfiguration]: https://docs.microsoft.com/en-us/powershell/module/psdesiredstateconfiguration/about/about_classes_and_dsc?view=powershell-7.1
[DnsRecordA]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordA
[DnsRecordAaaa]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordAaaa
[DnsRecordAaaaScoped]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordAaaaScoped
[DnsRecordAScoped]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordAScoped
[DnsRecordBase]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordBase
[DnsRecordCname]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordCname
[DnsRecordCnameScoped]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordCnameScoped
[DnsRecordMx]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordMx
[DnsRecordMxScoped]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordMxScoped
[DnsRecordNs]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordNs
[DnsRecordNsScoped]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordNsScoped
[DnsRecordPtr]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordPtr
[DnsRecordSrv]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordSrv
[DnsRecordSrvScoped]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsRecordSrvScoped
[DnsServerCache]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerCache
[DnsServerDsc]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerDsc
[DnsServerDsSetting]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerDsSetting
[DnsServerEDns]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerEDns
[DnsServerRecursion]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerRecursion
[DnsServerScavenging]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerScavenging
[DnsServerClientSubnet]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerClientSubnet
[DnsServerConditionalForwarder]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerConditionalForwarder
[DnsServerDiagnostics]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerDiagnostics
[DnsServerForwarder]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerForwarder
[DnsServerPrimaryZone]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerPrimaryZone
[DnsServerRootHint]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerRootHint
[DnsServerSecondaryZone]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerSecondaryZone
[DnsServerSetting]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerSetting
[DnsServerSettingLegacy]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerSettingLegacy
[DnsServerZoneAging]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerZoneAging
[DnsServerZoneScope]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerZoneScope
[DnsServerZoneTransfer]: https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerZoneTransfer
[Script]: https://github.com/dsccommunity/xPSDesiredStateConfiguration
[xWindowsFeature]: https://github.com/dsccommunity/xPSDesiredStateConfiguration
[Add-DnsServerQueryResolutionPolicy]: https://docs.microsoft.com/en-us/powershell/module/dnsserver/add-dnsserverqueryresolutionpolicy?view=windowsserver2022-ps&viewFallbackFrom=win10-ps
[Set-DnsServerQueryResolutionPolicy]: https://docs.microsoft.com/en-us/powershell/module/dnsserver/set-dnsserverqueryresolutionpolicy?view=windowsserver2022-ps&viewFallbackFrom=win10-ps
[Get-DnsServerQueryResolutionPolicy]: https://docs.microsoft.com/en-us/powershell/module/dnsserver/get-dnsserverqueryresolutionpolicy?view=windowsserver2022-ps&viewFallbackFrom=win10-ps