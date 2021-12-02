configuration DnsServerZoneTransfers
{
    param
    (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [System.Collections.Hashtable[]]
        $Zones
    )

    <#
        Import required modules
    #>
    Import-DscResource -ModuleName DnsServerDsc


    foreach ($z in $Zones)
    {
        $z = @{} + $z

        # create execution name for the resource
        $executionName = "Transfer_$("$($z.Name)_$($z.Type)_$($z.SecondaryServer)" -replace '[()-.:\s]', '_')"

        $object = @"

        Creating DSC resource for DnsServerZoneTransfer with the following values:

            DnsServerZoneTranser $($executionName)
            {
                Name                = '$($z.Name)'
                Type                = '$($z.Type)'
                SecondaryServer     = '$($z.SecondaryServer)'
            }

"@

            Write-Host "$object" -ForegroundColor Yellow

            # create DSC resource for DNS Server zones
            $Splatting = @{
                ResourceName  = 'DnsServerZoneTransfer'
                ExecutionName = $executionName
                Properties    = $z
                NoInvoke      = $true
            }
            (Get-DscSplattedResource @Splatting).Invoke($z)
    }
}