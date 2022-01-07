# Overview

The **ActiveDirectoryDnsSettings** DSC configuration manages DNS Active Directory settings on a Microsoft Domain Name System (DNS).

<br />

###### Table. Project Information
|                   |                                                                                                                                         |
| ----------------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| **Source**        | https://prod1gitlab.mapcom.local/dsc/configurations/DnsServerTasks/-/tree/master/DnsServerTasks/DscResources/ActiveDirectoryDnsSettings |
|                   |
| **DSC Resources** | [DnsServerDsc][DnsServerDsc],                                                                                                           |


<br />

##### Table. Attributes of *'ActiveDirectoryDnsSettings'*

| Parameter                                | Attribute  | DataType          | Description                                                                                                                                                                                                                                                                    | Allowed Values |
| ---------------------------------------- | ---------- | ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------- |
| **DnsServer**                            | *Required* | `[String]`        | The host name of the Domain Name System (DNS) server, or use `'localhost'` for the current node.                                                                                                                                                                               |                |
| **DirectoryPartitionAutoEnlistInterval** |            | `[String]`        | Specifies the interval, during which a DNS server tries to enlist itself in a DNS domain partition and DNS forest partition, if it is not already enlisted.                                                                                                                    |                |
| **LazyUpdateInterval**                   |            | `[System.UInt32]` | Specifies a value, in seconds, to determine how frequently the DNS server submits updates to the directory server without specifying the LDAP_SERVER_LAZY_COMMIT_OID control ([MS-ADTS] section 3.1.1.3.4.1.7) at the same time that it processes DNS dynamic update requests. |                |
| **MinimumBackgroundLoadThreads**         |            | `[System.UInt32]` | Specifies the minimum number of background threads that the DNS server uses to load zone data from the directory service.                                                                                                                                                      |                |
| **PollingInterval**                      |            | `[String]`        | Specifies how frequently the DNS server polls Active Directory Domain Services (AD DS) for changes in Active Directory-integrated zones.                                                                                                                                       |                |
| **RemoteReplicationDelay**               |            | `[System.UInt32]` | Specifies the minimum interval, in seconds, that the DNS server waits between the time that it determines that a single object has changed on a remote directory server, to the time that it tries to replicate a single object change.                                        |                |
| **TombstoneInterval**                    |            | `[String]`        | Specifies the amount of time that DNS keeps tombstoned records alive in Active Directory.                                                                                                                                                                                      |                |

<br />

#####  Example *ActiveDirectoryDnsSettings*

```yaml
ActiveDirectoryDnsSettings:
  DirectoryPartitionAutoEnlistInterval: '1.00:00:00'
  LazyUpdateInterval: 3
  MinimumBackgroundLoadThreads: 1
  PollingInterval: 180
  RemoteReplicationDelay: 30
  TombstoneInterval: '14.00:00:00'
```

<br />

##### Lookup Options in `Datum.yml`

```yaml
lookup_options:

  ActiveDirectoryDnsSettings:
    merge_hash: deep
```

<br />

[DnsServerDsc]: https://github.com/dsccommunity/DnsServerDsc