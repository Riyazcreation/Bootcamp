# Installs Windows Terminal color themes from this repo
# Usage: .\install.ps1 [-Theme "Neon Tokyo"] [-DryRun]
param(
    [string]$Theme = "",
    [switch]$DryRun
)

$settingsPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

if (-not (Test-Path $settingsPath)) {
    # Try Windows Terminal Preview path
    $settingsPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json"
}

if (-not (Test-Path $settingsPath)) {
    Write-Error "Windows Terminal settings.json not found. Is Windows Terminal installed?"
    exit 1
}

$settings = Get-Content $settingsPath -Raw | ConvertFrom-Json
if (-not $settings.schemes) {
    $settings | Add-Member -MemberType NoteProperty -Name "schemes" -Value @()
}

$themeFiles = if ($Theme) {
    Get-ChildItem "$PSScriptRoot\themes\*.json" | Where-Object {
        (Get-Content $_ | ConvertFrom-Json).name -eq $Theme
    }
} else {
    Get-ChildItem "$PSScriptRoot\themes\*.json"
}

$added = 0
foreach ($file in $themeFiles) {
    $theme = Get-Content $file -Raw | ConvertFrom-Json
    $existing = $settings.schemes | Where-Object { $_.name -eq $theme.name }
    if ($existing) {
        Write-Host "  [skip] '$($theme.name)' already installed" -ForegroundColor Yellow
    } else {
        if (-not $DryRun) {
            $settings.schemes += $theme
        }
        Write-Host "  [add]  '$($theme.name)'" -ForegroundColor Green
        $added++
    }
}

if (-not $DryRun -and $added -gt 0) {
    $settings | ConvertTo-Json -Depth 20 | Set-Content $settingsPath -Encoding UTF8
    Write-Host "`n$added theme(s) installed. Restart Windows Terminal to apply." -ForegroundColor Cyan
} elseif ($DryRun) {
    Write-Host "`nDry run — no changes written." -ForegroundColor DarkCyan
} else {
    Write-Host "`nNothing new to install." -ForegroundColor DarkCyan
}
