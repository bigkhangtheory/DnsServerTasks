<#
    .SYNOPSIS
        This DSC configuration manages a standalone file-backed secondary zone on a Domain Name System (DNS) server.
    .DESCRIPTION
        Secondary zones allow client machine in primary DNS zones to do DNS resolution of machines in the secondary DNS zone.
#>
#Requires -Module DnsServerDsc


configuration DnsServerSecondaryZones
{
    param
    (
        [Parameter()]
        [System.Collections.Hashtable[]]
        $SecondaryZones
    )


    <#
        Import required modules
    #>
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName DnsServerDsc

    <#
        This DSC resource depends on installation of Windows DNS Server
    #>
    WindowsFeature AddDns
    {
        Name   = 'DNS'
        Ensure = 'Present'
    }
    WindowsFeature AddRsatDnsServer
    {
        Name      = 'RSAT-DNS-Server'
        Ensure    = 'Present'
        DependsOn = '[WindowsFeature]AddDns'
    }
    $dependsOnRsatDnsServer = '[WindowsFeature]AddRsatDnsServer'

    <#
        Create DSC resource for secondary zones
    #>
    foreach ($s in $SecondaryZones)
    {
        Write-Host '-------------------------------------'
        Write-Host "Name = $($s.Name)"
        Write-Host "MasterServers = $($s.MasterServers)"
        Write-Host "Ensure = $($s.Ensure)"

        # remove case sensitivity for ordered Dictionary and Hashtables
        #$s = @{ } + $s

        $executionName = "$($s.Name -replace '[-().:\s]', '_')_$($s.MasterServers -replace '[-().:\s]', '_')"

        Write-Host "Execution Name = $($executionName)"

        DnsServerSecondaryZone "$executionName"
        {
            Name          = $s.Name
            MasterServers = $s.MasterServers
            Ensure        = $s.Ensure
            DependsOn     = $dependsOnRsatDnsServer
        }
    }
} #end configuration