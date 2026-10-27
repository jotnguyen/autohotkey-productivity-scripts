# Hand-off

Where this repo stands. Last updated 2026-10-27, when it was created.

## Status: written, not yet run

| Item | State |
|---|---|
| `CapsLockAltTab.ahk` | Written for AutoHotkey v2. **Never run**: AutoHotkey isn't installed on the owner's machine yet. |
| `scripts/Set-Startup.ps1` | Parses; `-WhatIf` shows the right Startup-folder shortcut. Not run for real. |
| Install | Waiting for the owner's OK to run `winget install --id AutoHotkey.AutoHotkey -e`. |
| Remote | None. Local commits only; don't push until the owner asks. |

## Next steps

1. With the owner's OK, install AutoHotkey v2 (`winget`, see README).
2. Run `CapsLockAltTab.ahk` and have the owner try it with a person at the keyboard:
   tap Caps Lock (previous window), hold Caps Lock and tap Tab (cycle), Shift+Caps Lock
   (real Caps Lock). Ask what actually happened.
3. If it works, run `scripts/Set-Startup.ps1` (ask first; it adds a startup shortcut).

## Why it's its own repo

It came out of the `alps-middle-scroll` session. A keyboard remap has nothing to do with
the Alps driver, and AutoHotkey's keyboard hook is the right tool; a hook inside that
repo's PowerShell tray would add latency to every keystroke whenever PowerShell is busy.

## Rules

See [AGENTS.md](AGENTS.md): noreply identity, no AI attribution, `bash scripts/hygiene.sh`
must print `hygiene-ok`, and ask before installing anything.
