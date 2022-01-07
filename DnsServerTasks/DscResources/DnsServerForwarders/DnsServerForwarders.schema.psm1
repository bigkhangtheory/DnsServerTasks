configuration DnsServerForwarders
{
    param
    (
        [Parameter(Mandatory)]
        [System.String[]]
        $IPAddresses,

        [Parameter()]
        [System.Boolean]
        $UseRootHint,

        [Parameter()]
        [System.Boolean]
        $EnableReordering,

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

    <#
        This resource requires an installation of DNS
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

    <#
        Create the DNS resource
    #>

    # define valid parameters for the DnsServerForwarder resource
    $properties = @(
        'IPAddresses',
        'UseRootHint',
        'EnableReordering',
        'Timeout'
    )

    # store parameters in hashtable
    $params = @{}
    foreach ($item in ($PSBoundParameters.GetEnumerator() | Where-Object Key -In $properties))
    {
        $params.Add($item.Key, $item.Value)
    }

    # if property 'UseRootHint' not specified, default to true
    if (-not $params.ContainsKey('UseRootHint'))
    {
        $params.UseRootHint = $true
    }

    # if property 'EnableReordering' not specified, default to true
    if (-not $params.ContainsKey('EnableReordering'))
    {
        $params.EnableReordering = $true
    }

    # if property 'Timeout' not specified, default to 3 seconds
    if (-not $params.ContainsKey('Timeout'))
    {
        $params.Timeout = 3
    }

    # this resource is single instanced
    $params.IsSingleInstance = 'Yes'

    # this resource depends on installation of DNS server
    $params.DependsOn = $dependsOnRsatDnsServer

    # create execution name for the resource
    $executionName = "Forwarders_$("$($params.IPAddresses)" -replace '[-().:\s]', '_')"


    # create the DNS resource
    $Splatting = @{
        ResourceName  = 'DnsServerForwarder'
        ExecutionName = $executionName
        Properties    = $params
        NoInvoke      = $true
    }
    (Get-DscSplattedResource @Splatting).Invoke($params)
} #end configuration
