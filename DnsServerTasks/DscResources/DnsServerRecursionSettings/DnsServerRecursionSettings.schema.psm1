<#
    .SYNOPSIS
        The DnsServerRecursionSettings DSC resource manages recursion settings on a Microsoft Domain Name System (DNS) server.

    .DESCRIPTION
        The DnsServerRecursionSettings DSC configuration manages recursion settings on a Microsoft
        Domain Name System (DNS) server. Recursion occurs when a DNS server queries
        other DNS servers on behalf of a requesting client, and then sends the answer
        back to the client.

        The property SecureResponse that can be set by the cmdlet Set-DnsServerRecursion
        changes the same value as EnablePollutionProtection in the resource DnsServerCache
        does. Use the property EnablePollutionProtection in the resource DnsServerCache
        to enforce pollution protection.

    .PARAMETER DnsServer
        Key - System.String
        The host name of the Domain Name System (DNS) server, or use 'localhost'
        for the current node.

    .PARAMETER Enable
        Write - Nullable[System.Boolean]
        Specifies whether the server enables recursion.

    .PARAMETER AdditionalTimeout
        Write - Nullable[System.UInt32]
        Specifies the time interval, in seconds, that a DNS server waits as it uses
        recursion to get resource records from a remote DNS server. Valid values are
        in the range of 1 second to 15 seconds. See recommendation in the documentation
        of https://docs.microsoft.com/en-us/powershell/module/dnsserver/set-dnsserverrecursion.

    .PARAMETER RetryInterval
        Write - Nullable[System.UInt32]
        Specifies elapsed seconds before a DNS server retries a recursive lookup.
        Valid values are in the range of 1 second to 15 seconds. The
        recommendation is that in general this value should not be change. However,
        under a few circumstances it can be considered changing the value. For
        example, if a DNS server contacts a remote DNS server over a slow link and
        retries the lookup before it gets a response, it could help to raise the
        retry interval to be slightly longer than the observed response time.
        See recommendation in the documentation of https://docs.microsoft.com/en-us/powershell/module/dnsserver/set-dnsserverrecursion.

    .PARAMETER Timeout
        Write - Nullable[System.UInt32]
        Specifies the number of seconds that a DNS server waits before it stops
        trying to contact a remote server. The valid value is in the range of 1
        second to 15 seconds. Recommendation is to increase this value when
        recursion occurs over a slow link. See recommendation in the documentation
        of https://docs.microsoft.com/en-us/powershell/module/dnsserver/set-dnsserverrecursion.
#>
#Requires -Module DnsServerDsc


configuration DnsServerRecursionSettings
{
    param
    (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $DnsServer,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.Boolean]
        $Enable,

        [Parameter()]
        [ValidateRange(1, 15)]
        [System.UInt32]
        $AdditionalTimeout,

        [Parameter()]
        [ValidateRange(1, 15)]
        [System.UInt32]
        $RetryInterval,

        [Parameter()]
        [ValidateRange(0, 15)]
        [System.String]
        $Timeout
    )

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName DnsServerDsc

    # boolean flag to track installation of DNS server
    [boolean]$dnsServerInstalled = $false

    # if 'DnsServer' is not specified, default to 'localhost'
    if (-not $PSBoundParameters.ContainsKey('DnsServer'))
    {
        $DnsServer = 'localhost'
    }

    # install DNS server if DNS record shall be set on a local DNS server
    if ($DnsServer -eq 'localhost')
    {
        <#
            Create DSC resource for installation of Windows Role DNS Server
        #>
        WindowsFeature AddDns
        {
            Name   = 'DNS'
            Ensure = 'Present'
        }
        <#
            Create DSC resource for installation of Windows Feature RSAT DNS Server
        #>
        WindowsFeature AddRsatDnsServer
        {
            Name      = 'RSAT-DNS-Server'
            Ensure    = 'Present'
            DependsOn = '[WindowsFeature]AddDns'
        }
        # set dependency reference
        $dependsOnRsatDnsServer = '[WindowsFeature]AddRsatDnsServer'

        # flag DNS server installation is true
        $dnsServerInstalled = $true
    } #end if


    <#
        Create the DNS resource
    #>

    # define valid parameters for the DnsServerForwarder resource
    $properties = @(
        'Enable',
        'AdditionalTimeout',
        'RetryInterval',
        'Timeout'
    )

    # store parameters in hashtable
    $params = @{}
    foreach ($item in ($PSBoundParameters.GetEnumerator() | Where-Object Key -In $properties))
    {
        $params.Add($item.Key, $item.Value)
    }

    # if property 'AdditionalTimeout' not specified, default to 4 secs
    if (-not $params.ContainsKey('AdditionalTimeout'))
    {
        $params.AdditionalTimeout = 4
    }

    # if property 'RetryInterval' not specified, default to 3 secs
    if (-not $params.ContainsKey('RetryInterval'))
    {
        $params.RetryInterval = 3
    }

    # if property 'Timeout' not specified, default to 15 seconds
    if (-not $params.ContainsKey('Timeout'))
    {
        $params.Timeout = 15
    }

    # if 'DnsServer' is localhost, this resource depends on installation of DNS server
    if ($dnsServerInstalled)
    {
        $params.DnsServer = $DnsServer
        $params.DependsOn = $dependsOnRsatDnsServer
    }

    # create execution name for the resource
    $executionName = "Recursion_$("$($params.DnsServer)_$($params.Enable)" -replace '[-().:\s]', '_')"


    # create the DNS resource
    $Splatting = @{
        ResourceName  = 'DnsServerRecursion'
        ExecutionName = $executionName
        Properties    = $params
        NoInvoke      = $true
    }
    (Get-DscSplattedResource @Splatting).Invoke($params)
} #end configuration