[CmdletBinding()]
param
(
	[Parameter(Mandatory=$true)]
	[string]$message
)

$ErrorActionPreference = "Stop";
$VerbosePreference = "Continue";

$here = Split-Path $script:MyInvocation.MyCommand.Path;

& "$here/update.ps1";

& git add -A

$args = @()
$args += "commit";
$args += "-m";
$args += "`"$message`""
& git $args