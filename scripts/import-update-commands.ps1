$ErrorActionPreference = "Stop";

$here = Split-Path $script:MyInvocation.MyCommand.Path;
$rootDirectoryPath = & "$here\_Find-RootDirectory.ps1" -SearchStart $here;

# find the update-commands file
$masterUpdateCommandsPath = "$rootDirectoryPath\src\update_commands.txt";

$workingUpdateCommandsPath = "$rootDirectoryPath\working\update_commands.txt";
$dummy = New-Item -ItemType File -Path $workingUpdateCommandspath -Force;

$importingUpdateCommandsPath = "C:\Program Files (x86)\Steam\SteamApps\common\Total War WARHAMMER\assembly_kit\raw_data\db\update_commands.txt";

# copy it to a working directory, changing the encoding to UTF-8 (so it can be diffed in git and show changes)
$content = Get-Content $importingUpdateCommandsPath
[System.IO.File]::WriteAllLines($workingUpdateCommandsPath, $content)

# check if different
$original = [System.IO.File]::ReadAllText($masterUpdateCommandsPath);
$new = [System.IO.File]::ReadAllText($workingUpdateCommandsPath);

if ($new -ne $original)
{
    # copy into expected location if different
    [System.IO.File]::WriteAllText($masterUpdateCommandsPath, $new);

    # increment the minor version by 1
    $packageFilePath = "$rootDirectoryPath\src\package.json";
    $package = ConvertFrom-Json ([System.IO.File]::ReadAllText($packageFilePath));
    $package.Version.Build = $package.Version.Build + 1;

    [System.IO.File]::WriteAllText($packageFilePath, (ConvertTo-Json $package));
}