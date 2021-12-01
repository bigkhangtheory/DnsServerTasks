configuration ActiveDirectoryDnsZones
{
    param
    (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Hashtable[]]
        $Zones,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.PSCredential]
        $Credential
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName DnsServerDsc

    foreach ($a in $Zones)
    {
        # remove case sensitivity
        $a = @{ } + $a

        # if 'ReplicationScope' not specified, default to 'Domain'
        if (-not $a.ContainsKey('ReplicationScope'))
        {
            $a.ReplicationScope = 'Domain'
        }

        # if 'ComputerName' not specified, default to this current node
        if (-not $a.ContainsKey('ComputerName'))
        {
            #$a.ComputerName = [System.Net.Dns]::GetHostByName("$($node.Name)").HostName
            $a.ComputerName = $node.Name
        }

        # if not specified, ensure present
        if (-not $a.ContainsKey('Ensure'))
        {
            $a.Ensure = 'Present'
        }

        if ($Credential)
        {
            $a.Credential = $Credential
        }

        $executionName = "$($node.Name)_$($a.Name)"

        (Get-DscSplattedResource -ResourceName DnsServerADZone -ExecutionName $executionName -Properties $a -NoInvoke).Invoke($a)
    }
}