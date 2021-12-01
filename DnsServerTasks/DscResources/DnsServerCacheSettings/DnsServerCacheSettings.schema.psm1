<#
    .SYNOPSIS
        This DSC configuration is used to manage cache settings on a Microsoft Domain Name System (DNS) server.
    .DESCRIPTION
        This DSC configuration is used to manage cache settings on a Microsoft Domain Name System (DNS) server.
    .PARAMETER IgnorePolicies
        Specifies whether to ignore policies for this cache.
    .PARAMETER LockingPercent
        Specifies a percentage of the original Time to Live (TTL) value that caching can consume.
    .PARAMETER MaxKBSize
        Specifies the maximum size, in kilobytes, of the memory cache of a DNS server. If set to 0 there is no limit.
    .PARAMETER MaxNegativeTtl
        Specifies how long an entry that records a negative answer to a query remains stored in the DNS cache.

        Minimum value is '00:00:01' and maximum value is '30.00:00:00'
    .PARAMETER MaxTtl
        Specifies how long a record is saved in cache.

        Minimum value is '00:00:00' and maximum value is '30.00:00:00'. If the TimeSpan is set to '00:00:00' (0 seconds), the DNS server does not cache records.
    .PARAMETER EnablePollutionProtection
        Specifies whether DNS filters name service (NS) resource records that are cached.

        Valid values are False ($false), which caches all responses to name queries; and True ($true), which caches only the records that belong to the same DNS subtree.

        When you set this parameter value to False ($false), cache pollution protection is disabled.

            - A DNS server caches the Host (A) record and all queried NS resources that are in the DNS server zone.
            - In this case, DNS can also cache  the NS record of an unauthorized DNS server.
            - This event causes name resolution to fail or to be appropriated for subsequent queries in the specified domain.

        When you set the value for this parameter to True ($true), the DNS server enables cache pollution protection and ignores the Host (A) record.

            - The DNS server performs a cache update query to resolve the address of the NS if the NS is outside the zone of the DNS server.
            - The additional query minimally affects DNS server performance.
    .PARAMETER StoreEmptyAuthenticationResponse
        Specifies whether a DNS server stores empty authoritative responses in the cache (RFC-2308).
    .LINK
        https://github.com/dsccommunity/DnsServerDsc/wiki/DnsServerCache
    .NOTES
        Khang M. Nguyen
        @bigkhangtheory
#>
#Requires -Module DnsServerDsc


configuration DnsServerCacheSettings
{
    param
    (
        [Parameter()]
        [System.String]
        $DnsServer,

        [Parameter()]
        [System.Boolean]
        $IgnorePolicies,

        [Parameter()]
        [System.UInt32]
        $LockingPercent,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.UInt32]
        $MaxKBSize,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $MaxNegativeTtl,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $MaxTtl,

        [Parameter()]
        [System.Boolean]
        $EnablePollutionProtection,

        [Parameter()]
        [System.Boolean]
        $StoreEmptyAuthenticationResponse
    )

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName DnsServerDsc

    <#
        Properties list of the DnsServerCache resource
    #>
    $resourceParams = @(
        'DnsServer',
        'IgnorePolicies',
        'LockingPercent',
        'MaxKBSize',
        'MaxNegativeTtl',
        'MaxTtl',
        'EnablePollutionProtection',
        'StoreEmptyAuthenticationResponse'
    )


    <#
        Create DSC resource for DnsServerCache
    #>
    $params = @{ }
    foreach ($item in ($PSBoundParameters.GetEnumerator() | Where-Object Key -In $resourceParams))
    {
        Write-Host -Message "$($item.Key) = $($item.Value)"
        $params.Add($item.Key, $item.Value)
    }



    # if not specified, set the DNS server to localhost
    if ($null -eq $params.DnsServer)
    {
        $params.DnsServer = 'localhost'
    }

    # if not specified, set 'IgnorePolicies' to false
    if ($null -eq $params.IgnorePolicies)
    {
        $params.IgnorePolicies = $false
    }

    # create execution name for the resource
    $executionName = "$($params.DnsServer -replace '[-().:\s]', '_')"

    $hashtable = @"

    Parameters = {
        DnsServer                           = $($params.DnsServer)
        IgnorePolicies                      = $($params.IgnorePolicies)
        LockingPercent                      = $($params.LockingPercent)
        MaxKBSize                           = $($params.MaxKBSize)
        MaxNegativeTtl                      = $($params.MaxNegativeTtl)
        EnablePollutionProtection           = $($params.EnablePollutionProtection)
        StoreEmptyAuthenticationResponse    = $($params.StoreEmptyAuthenticationResponse)
    }
"@

    Write-Host -Message 'Creating DSC resource with the following parameters:'
    Write-Host -Message $hashtable

    $Splatting = @{
        ResourceName  = 'DnsServerCache'
        ExecutionName = $executionName
        Properties    = $params
        NoInvoke      = $true
    }
    (Get-DscSplattedResource @Splatting).Invoke($params)
} #end configuration