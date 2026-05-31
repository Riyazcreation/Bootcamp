# cmd-toolkit

A power-user collection of CMD batch scripts for everyday Windows productivity.

## Scripts

### File & Folder Management
| Script | Description |
|--------|-------------|
| `bulk-rename.bat` | Rename files by pattern with preview |
| `flat-copy.bat` | Copy all files from nested folders into one flat dir |
| `find-dupes.bat` | Find duplicate files by size + name |
| `clean-empty.bat` | Delete all empty folders recursively |

### Network Tools
| Script | Description |
|--------|-------------|
| `wifi-info.bat` | Show connected SSID, IP, signal strength |
| `port-scan.bat` | Scan local ports and show listening services |
| `flush-reset.bat` | Flush DNS, reset Winsock, renew IP in one shot |
| `ping-sweep.bat` | Ping all hosts on a subnet |

### System Maintenance
| Script | Description |
|--------|-------------|
| `cleanup.bat` | Clear temp files, recycle bin, browser cache |
| `startup-list.bat` | List all startup programs with their paths |
| `disk-report.bat` | Drive usage summary with color alerts |
| `kill-hog.bat` | Find and kill the top CPU/memory-hungry process |

### Developer Utilities
| Script | Description |
|--------|-------------|
| `env-dump.bat` | Pretty-print all environment variables |
| `path-audit.bat` | Check PATH entries for broken/missing paths |
| `git-clean.bat` | Prune merged branches and stale remotes |
| `port-kill.bat` | Kill whatever process is on a given port |

## Usage

```bat
REM Run any script directly
bulk-rename.bat *.txt report_*.txt

REM See help for any script
bulk-rename.bat --help
```

## Requirements

- Windows 7+ (most scripts)
- Some scripts require admin privileges (noted in each file header)
