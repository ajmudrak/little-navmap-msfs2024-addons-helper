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
    sqlite3.exe -batch -bail -init "$scriptLoc\script-copy-2020-addons-to-userpoints.sql" -cmd '.exit' 'little_navmap_userdata.sqlite'
}
finally {
    Pop-Location
}
