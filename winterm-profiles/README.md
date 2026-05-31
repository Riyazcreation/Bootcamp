# winterm-profiles

Ready-to-use Windows Terminal profile configurations — drop them into your `settings.json` and level up your terminal game instantly.

## Profiles Included

| Profile | Shell | Specialty |
|---------|-------|-----------|
| `dev-powershell` | PowerShell 7 | Dev-optimized with Oh-My-Posh prompt |
| `wsl-ubuntu` | WSL2 Ubuntu | Zsh + Starship prompt |
| `git-bash` | Git Bash | Minimal, fast Git workflow |
| `admin-cmd` | CMD (Admin) | Elevated CMD with red accent |
| `azure-cloud` | Azure Cloud Shell | Pre-configured Azure CLI |
| `ssh-jump` | CMD | SSH jump-box launcher with saved hosts |
| `python-env` | CMD + venv | Auto-activates Python venv |
| `node-dev` | CMD + nvm | Node version manager ready |

## Features

- Custom `startingDirectory` per profile
- Per-profile fonts (Cascadia Code, JetBrains Mono, Fira Code)
- Custom background images with opacity settings
- Tab color-coding so you always know which shell is open
- Keybindings: `Ctrl+Shift+1..8` to open specific profiles instantly

## Installation

### Option 1: Manual
1. Open `%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_*\LocalState\settings.json`
2. Copy any profile object from `profiles/` into your `"list"` array
3. Copy matching `keybindings/` entries into your `"actions"` array

### Option 2: Merge Script
```powershell
# Merge all profiles into your current settings.json
.\merge-profiles.ps1

# Merge a single profile
.\merge-profiles.ps1 -Profile dev-powershell
```

## Folder Structure

```
winterm-profiles/
├── profiles/
│   ├── dev-powershell.json
│   ├── wsl-ubuntu.json
│   ├── git-bash.json
│   ├── admin-cmd.json
│   ├── azure-cloud.json
│   ├── ssh-jump.json
│   ├── python-env.json
│   └── node-dev.json
├── keybindings/
│   └── profile-shortcuts.json
├── fonts/             # Font download links + install instructions
├── backgrounds/       # Subtle terminal background images
└── merge-profiles.ps1
```

## Recommended Font

**Cascadia Code PL** — includes Powerline glyphs needed for Oh-My-Posh and Starship prompts.

Download: https://github.com/microsoft/cascadia-code/releases
