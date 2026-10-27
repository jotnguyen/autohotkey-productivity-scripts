# Hand-off

Where this repo stands. Last updated 2026-10-27, when `capslock-alttab` was merged in.

## Status

| Item | State |
|---|---|
| Cascade-Win, APM-Counter, Vimium | Unchanged since 2024. |
| `CapsLockAltTab.ahk` | Written for AutoHotkey v2. **Never run**: AutoHotkey isn't installed on the owner's machine yet. |
| `scripts/Set-Startup.ps1` | Now takes `-Script` (default `CapsLockAltTab.ahk`). Parses; `-WhatIf` only. Not run for real. |
| Install | Waiting for the owner's OK to run `winget install --id AutoHotkey.AutoHotkey -e`. |
| Old local repo | `Projects\capslock-alttab` is superseded by this one; delete it only when the owner says so. |

## Next steps

1. With the owner's OK, install AutoHotkey v2 (`winget`, see README).
2. Run `CapsLockAltTab.ahk` and have the owner try it with a person at the keyboard:
   tap Caps Lock (previous window), hold Caps Lock and tap Tab (cycle), Shift+Caps Lock
   (real Caps Lock). Ask what actually happened. Make sure Vimium.ahk isn't running.
3. If it works, run `scripts/Set-Startup.ps1` (ask first; it adds a startup shortcut).

## Rules

See [AGENTS.md](AGENTS.md): noreply identity, no AI attribution, `bash scripts/hygiene.sh`
must print `hygiene-ok`, and ask before installing anything or pushing.
