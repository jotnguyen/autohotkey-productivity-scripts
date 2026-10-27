# AGENTS.md: capslock-alttab

One AutoHotkey v2 script that makes Caps Lock act as Alt+Tab, plus a PowerShell
script that adds it to startup.

## Non-negotiables

- **Nothing personal in git.** No real `C:\Users\<name>` paths, personal emails,
  serials or tokens. `bash scripts/hygiene.sh` must print `hygiene-ok`. The hooks in
  `.githooks/` run it on every commit (`git config core.hooksPath .githooks`). Never
  bypass them with `--no-verify`.
- **No AI attribution** in commits or PRs. Commit with the repo's local noreply
  identity.
- **Ask before installing software** (AutoHotkey) or adding anything to startup.

## Code style

- AutoHotkey v2 syntax only (`#Requires AutoHotkey v2.0`).
- PowerShell: Windows PowerShell 5.1 compatible, ASCII only, comment-based help,
  `SupportsShouldProcess` on anything that writes.
