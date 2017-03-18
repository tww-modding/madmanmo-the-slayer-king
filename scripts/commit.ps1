[CmdletBinding()]
param
(
	[string]$message
)

$ErrorActionPreference = "Stop";
$VerbosePreference = "Continue";

$here = Split-Path $script:MyInvocation.MyCommand.Path;

& "$here/update.ps1";

& git add -A
& git commit -m "$message"