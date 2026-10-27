# Hand-off

Where this repo stands. Last updated 2026-10-27.

## Status

| Item | State |
|---|---|
| Cascade-Win, APM-Counter, Vimium | Code unchanged since 2024. All load cleanly under `AutoHotkey64.exe /Validate`. |
| `CapsLockAltTab.ahk` | Loads cleanly under `/Validate`. **Never run for real**: nobody has tried it at the keyboard yet. |
| `scripts/Set-Startup.ps1` | Takes `-Script` (default `CapsLockAltTab.ahk`). `-WhatIf` gives the right shortcut path, and a missing script throws. Never run for real. |
| AutoHotkey | v2.0.31 installed per-user with winget (`AutoHotkey.AutoHotkey`, hash verified), in `%LOCALAPPDATA%\Programs\AutoHotkey\v2`. |
| History | Rewritten on 2026-10-27, so every commit uses the noreply identity. The 2024 initial commit used to carry the owner's personal email. The GitHub repo was then deleted and recreated, with the same name, description and topics, so the old SHAs `5e82435` and `c848998` are gone from GitHub too. Re-clone any older checkout; never push one. |
| `capslock-alttab` | The old local repo, merged here with its history, then moved to the Recycle Bin. |

## Next steps

1. Test CapsLockAltTab with the owner at the keyboard. Make sure Vimium.ahk isn't running
   (both bind Caps Lock). Start it, then ask the owner to try each of these and say
   what actually happened:
   tap Caps Lock (previous window), hold Caps Lock and tap Tab (cycle), Shift+Tab while
   holding (back), Shift+Caps Lock (real Caps Lock on/off).
2. If it works, ask before running `scripts/Set-Startup.ps1`; it adds a Startup-folder shortcut.
3. Optional: the TODOs in the README for the older scripts.

## Rules

See [AGENTS.md](AGENTS.md): noreply identity, no AI attribution, `bash scripts/hygiene.sh`
must print `hygiene-ok`, and ask before installing anything, adding to startup or pushing.
