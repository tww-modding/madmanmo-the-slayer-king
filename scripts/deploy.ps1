[CmdletBinding()]
param
(
	[string]$version
)

$ErrorActionPreference = "Stop";
$VerbosePreference = "Continue";

$here = Split-Path $script:MyInvocation.MyCommand.Path;
$rootDirectoryPath = & "$here\_Find-RootDirectory.ps1" -SearchStart $here;

$modFilePath = "$rootDirectoryPath\mod.json";
$mod = ConvertFrom-Json ([System.IO.File]::ReadAllText($modFilePath));

$version = "$($mod.version.breaking).$($mod.version.patch).$($mod.version.build)"
$name = $mod.name;

$packName = "$name-$version.pack";
$imageName = "$name-$version.png";

$packFilePath = "$rootDirectoryPath\build\$version\$packName";
$imageFilePath = "$rootDirectoryPath\build\$version\$imageName";

$packFileDestinationPath = "C:\Program Files (x86)\Steam\SteamApps\common\Total War WARHAMMER\data\$packName";
$imageFileDestinationPath = "C:\Program Files (x86)\Steam\SteamApps\common\Total War WARHAMMER\data\$imageName";

Write-Verbose "Copying Mod [$packName] from [$packFilePath] to [$packFileDestinationPath]";
$packResult = Copy-Item -Path $modFilePath -Destination $packFileDestinationPath -Force;

Write-Verbose "Copying Mod Image [$imageName] from [$imageFilePath] to [$imageFileDestinationPath]";
$imageResult = Copy-Item -Path $modFilePath -Destination $packFileDestinationPath -Force;