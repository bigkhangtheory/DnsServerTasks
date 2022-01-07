configuration DnsServerRootHints
{
    param
    (
        [Parameter()]
        [System.Collections.Hashtable]
        $RootHints
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName DnsServerDsc

    $param = @{
        IsSingleInstance = 'Yes'
        NameServer       = $RootHints
    }

    $executionName = 'RootHints'
    (Get-DscSplattedResource -ResourceName DnsServerRootHint -ExecutionName $executionName -Properties $param -NoInvoke).Invoke($param)
}
