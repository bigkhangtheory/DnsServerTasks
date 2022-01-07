# DnsServerDsSetting

## Parameters

| Parameter                                | Attribute  | DataType          | Description                                                                                                                                                                                                                                                                    | Allowed Values |
| ---------------------------------------- | ---------- | ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------- |
| **DnsServer**                            | *Required* | `[String]`        | The host name of the Domain Name System (DNS) server, or use `'localhost'` for the current node.                                                                                                                                                                               |                |
| **DirectoryPartitionAutoEnlistInterval** |            | `[String]`        | Specifies the interval, during which a DNS server tries to enlist itself in a DNS domain partition and DNS forest partition, if it is not already enlisted.                                                                                                                    |                |
| **LazyUpdateInterval**                   |            | `[System.UInt32]` | Specifies a value, in seconds, to determine how frequently the DNS server submits updates to the directory server without specifying the LDAP_SERVER_LAZY_COMMIT_OID control ([MS-ADTS] section 3.1.1.3.4.1.7) at the same time that it processes DNS dynamic update requests. |                |
| **MinimumBackgroundLoadThreads**         |            | `[System.UInt32]` | Specifies the minimum number of background threads that the DNS server uses to load zone data from the directory service.                                                                                                                                                      |                |
| **PollingInterval**                      |            | `[String]`        | Specifies how frequently the DNS server polls Active Directory Domain Services (AD DS) for changes in Active Directory-integrated zones.                                                                                                                                       |                |
| **RemoteReplicationDelay**               |            | `[System.UInt32]` | Specifies the minimum interval, in seconds, that the DNS server waits between the time that it determines that a single object has changed on a remote directory server, to the time that it tries to replicate a single object change.                                        |                |
| **TombstoneInterval**                    |            | `[String]`        | Specifies the amount of time that DNS keeps tombstoned records alive in Active Directory.                                                                                                                                                                                      |                |

## Description

The DnsServerDsSetting DSC resource manages DNS Active Directory settings
on a Microsoft Domain Name System (DNS) server.

## Examples

### Example 1

This configuration will change the Directory Partition Auto Enlist
Interval in Active Directory.

```powershell
configuration DnsServerDsSetting_DirectoryPartitionAutoEnlistInterval_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    node localhost
    {
        DnsServerDsSetting 'Integration_Test'
        {
            DnsServer    = 'localhost'
            DirectoryPartitionAutoEnlistInterval = '1.00:00:00'
        }
    }
}
```

### Example 2

This configuration will change the Lazy Update
Interval in Active Directory.

```powershell
configuration DnsServerDsSetting_LazyUpdateInterval_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    node localhost
    {
        DnsServerDsSetting 'Integration_Test'
        {
            DnsServer    = 'localhost'
            LazyUpdateInterval = 3
        }
    }
}
```

### Example 3

This configuration will change the Minimum Background Load Threads
in Active Directory.

```powershell
configuration DnsServerDsSetting_MinimumBackgroundLoadThreads_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    node localhost
    {
        DnsServerDsSetting 'Integration_Test'
        {
            DnsServer       = 'localhost'
            MinimumBackgroundLoadThreads = 1
        }
    }
}
```

### Example 4

This configuration will change the Polling
Interval in Active Directory.

```powershell
configuration DnsServerDsSetting_PollingInterval_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    node localhost
    {
        DnsServerDsSetting 'Integration_Test'
        {
            DnsServer       = 'localhost'
            PollingInterval = 180
        }
    }
}
```

### Example 5

This configuration will change the Remote Replication Delay
in Active Directory.

```powershell
configuration DnsServerDsSetting_RemoteReplicationDelay_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    node localhost
    {
        DnsServerDsSetting 'Integration_Test'
        {
            DnsServer    = 'localhost'
            RemoteReplicationDelay = 30
        }
    }
}
```

### Example 6

This configuration will change the DNS Tombstone
Interval in Active Directory.

```powershell
configuration DnsServerDsSetting_TombstoneInterval_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    node localhost
    {
        DnsServerDsSetting 'Integration_Test'
        {
            DnsServer    = 'localhost'
            TombstoneInterval = '14.00:00:00'
        }
    }
}
```

### Example 7

This configuration will set all Active Directory-based DNS settings on
the specified server.

```powershell
configuration DnsServerDsSetting_All_Config
{
    Import-DscResource -ModuleName 'DnsServerDsc'

    node localhost
    {
        DnsServerDsSetting 'Integration_Test'
        {
            DnsServer    = 'localhost'
            DirectoryPartitionAutoEnlistInterval = '1.00:00:00'
            LazyUpdateInterval = 3
            MinimumBackgroundLoadThreads = 1
            PollingInterval = 180
            RemoteReplicationDelay = 30
            TombstoneInterval = '14.00:00:00'
        }
    }
}
```
