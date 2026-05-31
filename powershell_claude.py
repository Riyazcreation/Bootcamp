"""
PowerShell + Claude Integration
Interactive CLI: ask Claude PowerShell questions, execute suggested commands, and feed output back.
"""

import re
import subprocess
import sys
import shutil
from typing import Optional

import anthropic

MODEL = "claude-sonnet-4-6"

SYSTEM_PROMPT = """You are an expert Windows PowerShell assistant. Help users accomplish tasks using PowerShell.

When you suggest PowerShell commands:
- Always wrap them in a fenced code block tagged with 'powershell', for example:
  ```powershell
  Get-Process
  ```
- Explain what each command does before or after the block.
- Prefer safe, non-destructive commands when possible.
- If a command can modify or delete data, warn the user first.
- For multi-step tasks, show each step as a separate code block.

When the user shares command output, analyse it and help them interpret the results or suggest next steps.
"""


def find_powershell() -> Optional[str]:
    """Return the path to pwsh (PowerShell Core) or powershell.exe, whichever is available."""
    for exe in ("pwsh", "powershell"):
        path = shutil.which(exe)
        if path:
            return path
    return None


def extract_powershell_blocks(text: str) -> list[str]:
    """Extract all ```powershell ... ``` code blocks from text."""
    pattern = r"```(?:powershell|ps1)\s*\n(.*?)```"
    return re.findall(pattern, text, re.DOTALL | re.IGNORECASE)


def run_powershell(command: str, ps_path: str) -> tuple[str, str, int]:
    """Execute a PowerShell command string. Returns (stdout, stderr, returncode)."""
    try:
        result = subprocess.run(
            [ps_path, "-NoProfile", "-NonInteractive", "-Command", command],
            capture_output=True,
            text=True,
            timeout=60,
        )
        return result.stdout, result.stderr, result.returncode
    except subprocess.TimeoutExpired:
        return "", "Command timed out after 60 seconds.", 1
    except Exception as exc:
        return "", str(exc), 1


def prompt_execute(blocks: list[str], ps_path: str) -> str:
    """Offer each PowerShell block to the user for execution. Returns combined output text."""
    outputs = []
    for i, block in enumerate(blocks, 1):
        print(f"\n{'─'*60}")
        print(f"PowerShell command {i} of {len(blocks)}:")
        print(f"{'─'*60}")
        print(block.strip())
        print(f"{'─'*60}")
        choice = input("Execute this command? [y/N]: ").strip().lower()
        if choice == "y":
            print("Running...\n")
            stdout, stderr, rc = run_powershell(block.strip(), ps_path)
            output_parts = []
            if stdout:
                print(stdout)
                output_parts.append(f"STDOUT:\n{stdout}")
            if stderr:
                print(f"STDERR: {stderr}", file=sys.stderr)
                output_parts.append(f"STDERR:\n{stderr}")
            output_parts.append(f"Exit code: {rc}")
            outputs.append("\n".join(output_parts))
        else:
            print("Skipped.")
    return "\n\n".join(outputs)


def chat(client: anthropic.Anthropic, history: list[dict], user_msg: str) -> str:
    """Send a message, append to history, return assistant reply."""
    history.append({"role": "user", "content": user_msg})
    response = client.messages.create(
        model=MODEL,
        max_tokens=4096,
        system=SYSTEM_PROMPT,
        messages=history,
    )
    reply = response.content[0].text
    history.append({"role": "assistant", "content": reply})
    return reply


def main() -> None:
    ps_path = find_powershell()
    if ps_path:
        print(f"PowerShell found: {ps_path}")
    else:
        print("Warning: PowerShell not found on PATH. Command execution will be unavailable.")

    client = anthropic.Anthropic()
    history: list[dict] = []

    print("\nPowerShell + Claude  (type 'exit' or 'quit' to stop)\n")

    while True:
        try:
            user_input = input("You: ").strip()
        except (EOFError, KeyboardInterrupt):
            print("\nGoodbye!")
            break

        if not user_input:
            continue
        if user_input.lower() in ("exit", "quit"):
            print("Goodbye!")
            break

        reply = chat(client, history, user_input)
        print(f"\nClaude: {reply}\n")

        if ps_path:
            blocks = extract_powershell_blocks(reply)
            if blocks:
                output = prompt_execute(blocks, ps_path)
                if output:
                    follow_up = f"I ran the command(s). Here is the output:\n\n{output}\n\nPlease interpret these results and suggest any next steps."
                    follow_reply = chat(client, history, follow_up)
                    print(f"\nClaude: {follow_reply}\n")


if __name__ == "__main__":
    main()
