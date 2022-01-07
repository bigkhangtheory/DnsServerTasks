<#
    .SYNOPSIS
        This DSC configuration manages a standalone file-backed secondary zone on a Domain Name System (DNS) server.
    .DESCRIPTION
        Secondary zones allow client machine in primary DNS zones to do DNS resolution of machines in the secondary DNS zone.
#>
#Requires -Module DnsServerDsc
#Requires -Module 'Indented.Net.IP'


configuration DnsServerSecondaryZones
{
    param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [System.String[]]
        $MasterServers,

        [Parameter()]
        [System.String[]]
        $ForwardLookupZones,

        [Parameter()]
        [System.String[]]
        $ReverseLookupZones
    )


    <#
        Import required modules
    #>
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName DnsServerDsc

    Import-Module -Name 'Indented.Net.IP'

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
        Create DSC resource for secondary forward lookup zones
    #>
    if ($PSBoundParameters.ContainsKey('ForwardLookupZones'))
    {
        foreach ($f in $ForwardLookupZones)
        {
            # create hashtable to store resource parameters
            $params = @{}

            # assign the name of the Secondary zone
            $params.Name = $f


            # assign the master services for the Secondary zone
            $params.MasterServers = $MasterServers

            # ensure the source is 'Present' by default
            $params.Ensure = 'Present'

            # if prefix, parse the prefix and ensure 'Absent' for '-'
            if ($f[0] -in '-', '+')
            {
                if ($f[0] -eq '-')
                {
                    $params.Ensure = 'Absent'
                }
                $f = $f.Substring(1)
            }

            # set the Secondary zone name
            $params.Name = $f

            # this resource depends on installation of DNS
            $params.DependsOn = $dependsOnRsatDnsServer

            # create execution name for the resource
            $executionName = "$("$($params.Name)_$($params.MasterServers)" -replace '[-().:\s]', '_')"

            $object = @"

        Creating DSC resource for DnsServerSecondaryZone with the following values:

        DnsServerSecondaryZone $($executionName)
        {
            Name                = '$($params.Name)'
            MasterServers       = '$($params.MasterServers)'
            Ensure              = '$($params.Ensure)'
            DependsOn           = '$($params.DependsOn)'
        }

"@
            Write-Host $object -ForegroundColor Yellow
            # create DSC resource
            $Splatting = @{
                ResourceName  = 'DnsServerSecondaryZone'
                ExecutionName = $executionName
                Properties    = $params
                NoInvoke      = $true
            }
        (Get-DscSplattedResource @Splatting).Invoke($params)
        } #end foreach
    } #end ForwardLookupZones


    <#
        Create DSC resource for secondary reverse lookup zones
    #>
    if ($PSBoundParameters.ContainsKey('ReverseLookupZones'))
    {
        foreach ($r in $ReverseLookupZones)
        {
            Write-Host "        Found entry for $r" -ForegroundColor Yellow

            # hashtable for building parameters
            $params = @{}

            Write-Host "        Setting Master Servers list for $r" -ForegroundColor Yellow
            # assign the master services for the Secondary zone
            $params.MasterServers = $MasterServers


            Write-Host "        Setting Ensure for $r" -ForegroundColor Yellow
            # ensure the source is 'Present' by default
            $params.Ensure = 'Present'

            # if prefix, parse the prefix and ensure 'Absent' for '-'
            if ($r[0] -in '-', '+')
            {
                Write-Host '        Prefix was found.' -ForegroundColor Yellow
                if ($r[0] -eq '-')
                {
                    Write-Host '        Setting Ensure to Absent' -ForegroundColor Yellow
                    $params.Ensure = 'Absent'
                }
                Write-Host '        Removing prefix' -ForegroundColor Yellow
                $r = $r.Substring(1)
            }

            # this resource depends on installation of DNS
            $params.DependsOn = $dependsOnRsatDnsServer

            # construct the reverse lookup zone name
            $network = Get-SubNet -IPAddress $r -NewSubnetMask '255.255.255.0'

            # at this point, the specified IP Subnet has been partitioned into /24 subnets
            # loop through each /24 subnet and define the resource
            foreach ($n in $network)
            {
                Write-Host "`t`t`t`tCreating Reverse Lookup Secondary Zone for $n" -ForegroundColor Yellow

                # divide each network address into octet sections
                $octets = $n.NetworkAddress.IPAddressToString.Split('.')

                # format the reverse zone name
                $params.Name = '{0}.{1}.{2}.in-addr.arpa' -f $octets[2], $octets[1], $octets[0]

                # create execution name for the resource
                $executionName = "$("$($params.Name)_$($params.MasterServers)" -replace '[-().:\s]', '_')"

                $object = @"

                    Creating DSC resource for DnsServerSecondaryZone with the following values:

                    DnsServerSecondaryZone $($executionName)
                    {
                        Name                = '$($params.Name)'
                        MasterServers       = '$($params.MasterServers)'
                        Ensure              = '$($params.Ensure)'
                        DependsOn           = '$($params.DependsOn)'
                    }

"@
                Write-Host $object -ForegroundColor Yellow
                # create DSC resource
                $Splatting = @{
                    ResourceName  = 'DnsServerSecondaryZone'
                    ExecutionName = $executionName
                    Properties    = $params
                    NoInvoke      = $true
                }
                (Get-DscSplattedResource @Splatting).Invoke($params)
            } #end foreach
        } #end foreach
    } #end ReverseLookupZones
} #end configuration