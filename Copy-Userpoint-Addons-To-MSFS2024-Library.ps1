param (

)
$ErrorActionPreference = 'Stop'

Push-Location "$env:APPDATA\ABarthel\little_navmap_db"
$scriptLoc = $PSScriptRoot
if ("$scriptLoc".Trim() -eq '') {
    $scriptLoc = '.'
}

Write-Output $scriptLoc

try {
    sqlite3.exe -batch -bail -init "$scriptLoc\script-copy-userpoint-addons-to-msfs2024-library.sql" -cmd '.exit' 'little_navmap_msfs24.sqlite'
}
finally {
    Pop-Location
}
