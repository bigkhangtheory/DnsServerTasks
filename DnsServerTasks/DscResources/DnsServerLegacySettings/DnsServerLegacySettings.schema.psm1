<#
    .DESCRIPTION
        The DnsServerLegacySettings DSC resource manages the Domain Name System (DNS) server legacy settings.
#>
#Requires -Module DnsServer


configuration DnsServerLegacySettings
{
    param
    (
        [Parameter()]
        [System.String]
        $DnsServer = 'localhost',

        [Parameter()]
        [System.UInt32]
        $LogLevel,

        [Parameter()]
        [System.Boolean]
        $DisjointNets,

        [Parameter()]
        [System.Boolean]
        $NoForwarderRecursion,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential
    )

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName DnsServerDsc


    # define valid parameters for the DnsServerSettingLegacy resource
    $properties = @(
        'DnsServer',
        'DisjointNets',
        'NoForwarderRecursion',
        'LogLevel'
    )


    # boolean flag to track installation of DNS server
    [boolean]$dnsServerInstalled = $false

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


    # store parameters in hashtable
    $params = @{}
    foreach ($item in ($PSBoundParameters.GetEnumerator() | Where-Object Key -In $properties))
    {
        $params.Add($item.Key, $item.Value)
    }

    # if property 'DisjointNets' not specified, default to 4 secs
    if (-not $params.ContainsKey('DisjointNets'))
    {
        $params.DisjointNets = $true
    }

    # if property 'NoForwarderRecursion' not specified, default to 3 secs
    if (-not $params.ContainsKey('NoForwarderRecursion'))
    {
        $params.NoForwarderRecursion = $true
    }

    # if Credential is specified, set PsDscRunAsCredential
    if ($PSBoundParameters.ContainsKey('Credential'))
    {
        $params.PsDscRunAsCredential = $Credential
    }

    # if this configuration is applied to localhost, set dependency
    if ($dnsServerInstalled)
    {
        $params.DependsOn = $dependsOnRsatDnsServer
    }

    # create execution name for the resource
    $executionName = "DnsServerSettingLegacy_$("$($params.DnsServer)" -replace '[-().:\s]', '_')"

    # create the resource
    $Splatting = @{
        ResourceName  = 'DnsServerSettingLegacy'
        ExecutionName = $executionName
        Properties    = $params
        NoInvoke      = $true
    }
    (Get-DscSplattedResource @Splatting).Invoke($params)
} #end configuration