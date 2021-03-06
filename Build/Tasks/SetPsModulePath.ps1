<#
    .SYNOPSIS
        This task establishes the PowerShell virtual environment.
#>
task SetPsModulePath {
    if (-not ([System.IO.Path]::IsPathRooted($BuildOutput)))
    {
        $BuildOutput = Join-Path -Path $ProjectPath -ChildPath $BuildOutput
    }

    $configurationPath = Join-Path -Path $ProjectPath -ChildPath $ConfigurationsFolder
    $resourcePath = Join-Path -Path $ProjectPath -ChildPath $ResourcesFolder
    $buildModulesPath = Join-Path -Path $BuildOutput -ChildPath Modules

    $moduleToLeaveLoaded = @(
        'InvokeBuild',
        'PSReadline',
        'PackageManagement',
        'ISESteroids',
        'PowerShellGet',
        'Indented.Net.IP'
    )

    $pathToSet = $buildModulesPath #, $env:BHBuildOutput
    if ($env:BHBuildSystem -eq 'AppVeyor')
    {
        $pathToSet += ';C:\Program Files\AppVeyor\BuildAgent\Modules'
    }

    Set-PSModulePath -ModuleToLeaveLoaded $moduleToLeaveLoaded -PathsToSet $pathToSet

    "`n"
    'PSModulePath:'
    $env:PSModulePath -split ';'
    "`n"
}
