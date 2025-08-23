param (
    $OutputPath
)
$ErrorActionPreference = 'Stop'

$scriptLoc = $PSScriptRoot
if ("$scriptLoc".Trim() -eq '') {
    $scriptLoc = '.'
}

if ("$OutputPath".Trim() -eq '') {
    $OutputPath = "$scriptLoc\build"
}

if (!(Test-Path -Path $OutputPath)) {
    mkdir $OutputPath
}

$outputFile = "$OutputPath\little-navmap-msfs2024-addons-helper.zip"

if ((Test-Path -Path $outputFile)) {
    Remove-Item -Force $outputFile
}

$sourceFileList = @(
    'Copy-2020-Addons-To-MSFS2024-Library.ps1';
    'Copy-2020-Addons-To-Userpoints.ps1';
    'Copy-Userpoint-Addons-To-MSFS2024-Library.ps1';
    'script-copy-2020-addons-to-msfs2024-library.sql';
    'script-copy-2020-addons-to-userpoints.sql';
    'script-copy-userpoint-addons-to-msfs2024-library.sql';
)

Compress-Archive -Path $sourceFileList -DestinationPath $outputFile
