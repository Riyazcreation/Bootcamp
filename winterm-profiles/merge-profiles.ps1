# Merges profiles and keybindings from this repo into Windows Terminal settings.json
# Usage: .\merge-profiles.ps1 [-Profile "Dev PowerShell"] [-DryRun]
param(
    [string]$Profile = "",
    [switch]$DryRun
)

function Find-SettingsPath {
    $paths = @(
        "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json",
        "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json"
    )
    foreach ($p in $paths) { if (Test-Path $p) { return $p } }
    return $null
}

$settingsPath = Find-SettingsPath
if (-not $settingsPath) {
    Write-Error "Windows Terminal settings.json not found."
    exit 1
}

Write-Host "Settings: $settingsPath" -ForegroundColor DarkCyan

$settings = Get-Content $settingsPath -Raw | ConvertFrom-Json

if (-not $settings.profiles) { $settings | Add-Member -MemberType NoteProperty -Name "profiles" -Value @{} }
if (-not $settings.profiles.list) { $settings.profiles | Add-Member -MemberType NoteProperty -Name "list" -Value @() }
if (-not $settings.actions) { $settings | Add-Member -MemberType NoteProperty -Name "actions" -Value @() }

$profileFiles = if ($Profile) {
    Get-ChildItem "$PSScriptRoot\profiles\*.json" | Where-Object {
        (Get-Content $_ | ConvertFrom-Json).name -eq $Profile
    }
} else {
    Get-ChildItem "$PSScriptRoot\profiles\*.json"
}

$added = 0
foreach ($file in $profileFiles) {
    $p = Get-Content $file -Raw | ConvertFrom-Json
    $existing = $settings.profiles.list | Where-Object { $_.guid -eq $p.guid }
    if ($existing) {
        Write-Host "  [skip] '$($p.name)' already exists" -ForegroundColor Yellow
    } else {
        if (-not $DryRun) { $settings.profiles.list += $p }
        Write-Host "  [add]  '$($p.name)'" -ForegroundColor Green
        $added++
    }
}

$keybindFile = "$PSScriptRoot\keybindings\profile-shortcuts.json"
if (Test-Path $keybindFile) {
    $kb = (Get-Content $keybindFile | ConvertFrom-Json).actions
    foreach ($action in $kb) {
        $dup = $settings.actions | Where-Object { $_.keys -eq $action.keys }
        if (-not $dup) {
            if (-not $DryRun) { $settings.actions += $action }
            Write-Host "  [keybind] $($action.keys)" -ForegroundColor Cyan
        }
    }
}

if (-not $DryRun -and $added -gt 0) {
    $settings | ConvertTo-Json -Depth 20 | Set-Content $settingsPath -Encoding UTF8
    Write-Host "`n$added profile(s) merged. Restart Windows Terminal to apply." -ForegroundColor Green
} elseif ($DryRun) {
    Write-Host "`nDry run — no changes written." -ForegroundColor DarkCyan
} else {
    Write-Host "`nNothing new to merge." -ForegroundColor DarkCyan
}
