# terminal-art

ASCII art generators, animations, and visual effects — all running in CMD/batch with zero dependencies.

## Features

- Animated loading spinners & progress bars
- Matrix-style falling characters
- ASCII banner generator (custom text → big block letters)
- Bouncing ball animation
- Fireworks display (New Year / celebration)
- Clock: real-time ASCII digital clock in terminal
- Lolcat-style color gradient text output

## Gallery

```
 _   _ _____ _    _     ___
| | | | ____| |  | |   / _ \
| |_| |  _| | |  | |  | | | |
|  _  | |___| |__| |__| |_| |
|_| |_|_____|_____\____/\___/

WORLD
```

## Scripts

| Script | Description |
|--------|-------------|
| `banner.bat` | Print big block-letter banners from any text |
| `matrix.bat` | Scrolling green Matrix rain |
| `spinner.bat` | Reusable animated spinner (importable) |
| `progress.bat` | Colored progress bar with ETA |
| `clock.bat` | Live ASCII digital clock |
| `fireworks.bat` | Celebratory fireworks burst |
| `bounce.bat` | Bouncing ball physics demo |
| `gradient.bat` | Print text with color gradient |
| `typewriter.bat` | Type text character-by-character with sound |

## Usage

```bat
REM Big ASCII banner
banner.bat "HELLO WORLD"

REM Matrix rain (Ctrl+C to stop)
matrix.bat

REM Countdown timer with progress bar
progress.bat 60

REM Digital clock
clock.bat
```

## Fun Examples

```bat
REM New Year countdown
progress.bat 10 && fireworks.bat

REM Hacker aesthetic login screen
matrix.bat 3 && banner.bat "ACCESS GRANTED"
```
