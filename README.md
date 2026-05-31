# PowerShell + Claude Integration

An interactive CLI that connects Claude AI to Windows PowerShell. Ask Claude PowerShell questions in plain English, optionally execute the suggested commands, and have Claude interpret the results.

## Requirements

- Python 3.11+
- An Anthropic API key
- Windows PowerShell (`powershell.exe`) **or** PowerShell Core (`pwsh`) — works on Windows, macOS, and Linux

## Setup

```bash
pip install -r requirements.txt
export ANTHROPIC_API_KEY="your-key-here"   # Windows: set ANTHROPIC_API_KEY=your-key-here
```

## Usage

```bash
python powershell_claude.py
```

### Example session

```
PowerShell found: /usr/bin/pwsh

PowerShell + Claude  (type 'exit' or 'quit' to stop)

You: List all running processes sorted by CPU usage

Claude: To list all running processes sorted by CPU usage in PowerShell, use:

  ```powershell
  Get-Process | Sort-Object CPU -Descending | Select-Object -First 20 Name, CPU, Id
  ```

────────────────────────────────────────────────────────────
PowerShell command 1 of 1:
────────────────────────────────────────────────────────────
Get-Process | Sort-Object CPU -Descending | Select-Object -First 20 Name, Id, CPU
────────────────────────────────────────────────────────────
Execute this command? [y/N]: y
Running...

Name        Id    CPU
----        --    ---
chrome    1234  45.23
...

Claude: The output shows the top 20 processes by CPU time. 'chrome' is currently consuming the most...
```

## How it works

1. Your message is sent to Claude with a PowerShell-expert system prompt.
2. Claude's response is printed in the terminal.
3. Any ` ```powershell ``` ` code blocks are extracted and offered for execution one by one.
4. If you confirm execution (`y`), the command runs via `pwsh`/`powershell.exe`.
5. Stdout, stderr, and exit code are fed back to Claude for interpretation.
6. The full conversation history is preserved for context.

## Safety notes

- You are prompted before **every** command — nothing runs without your approval.
- Commands that modify or delete data will be flagged by Claude in its explanation.
- A 60-second timeout prevents runaway commands.
