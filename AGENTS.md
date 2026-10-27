# AGENTS.md: autohotkey-productivity-scripts

Public repo of standalone AutoHotkey v2 scripts in the root (Cascade-Win, APM-Counter,
Vimium, CapsLockAltTab), plus a PowerShell script that adds one to startup.
CapsLockAltTab came from a separate local repo, `capslock-alttab`, merged in with its
history on 2026-10-27.

## Non-negotiables

- **Nothing personal in git.** No real `C:\Users\<name>` paths, personal emails,
  serials or tokens. `bash scripts/hygiene.sh` must print `hygiene-ok`. The hooks in
  `.githooks/` run it on every commit (`git config core.hooksPath .githooks`). Never
  bypass them with `--no-verify`.
- **No AI attribution** in commits or PRs. Commit with the repo's local noreply
  identity.
- **Ask before installing software** (AutoHotkey), adding anything to startup, or
  pushing.

## Code style

- AutoHotkey v2 syntax only (`#Requires AutoHotkey v2.0`). One script per file in the
  root; each must run on its own.
- Vimium.ahk and CapsLockAltTab.ahk both bind Caps Lock. Don't make one depend on the
  other, and keep the README warning about running them together.
- PowerShell: Windows PowerShell 5.1 compatible, ASCII only, comment-based help,
  `SupportsShouldProcess` on anything that writes.
