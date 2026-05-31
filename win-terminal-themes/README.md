# win-terminal-themes

A curated collection of beautiful color schemes for Windows Terminal.

## Themes Included

| Theme | Style | Vibe |
|-------|-------|------|
| Neon Tokyo | Dark | Cyberpunk pink & cyan |
| Forest Dawn | Dark | Earthy greens & amber |
| Arctic Ice | Light | Cool blues & white |
| Volcanic | Dark | Deep reds & orange |
| Sakura | Light | Soft pinks & pastels |
| Matrix Rain | Dark | Classic green on black |
| Midnight Gold | Dark | Gold accent on navy |
| Desert Sand | Light | Warm tans & sunset hues |

## Installation

1. Open Windows Terminal settings (`Ctrl+,`)
2. Click **Open JSON file** (bottom-left gear icon)
3. Find the `"schemes"` array in the JSON
4. Paste any theme object from the `themes/` folder into that array
5. Set your profile's `"colorScheme"` to the theme name
6. Save and enjoy

## Folder Structure

```
win-terminal-themes/
├── themes/
│   ├── neon-tokyo.json
│   ├── forest-dawn.json
│   ├── arctic-ice.json
│   ├── volcanic.json
│   ├── sakura.json
│   ├── matrix-rain.json
│   ├── midnight-gold.json
│   └── desert-sand.json
├── previews/          # Screenshots of each theme
└── install.ps1        # Batch installer script
```

## Quick Install (PowerShell)

```powershell
# Install all themes at once
.\install.ps1

# Install a single theme
.\install.ps1 -Theme "Neon Tokyo"
```
