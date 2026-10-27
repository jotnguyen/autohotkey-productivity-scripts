# capslock-alttab

Caps Lock becomes Alt+Tab, so switching windows on one monitor takes one key
instead of two. It's an [AutoHotkey v2](https://www.autohotkey.com/) script.

| Keys | What happens |
|---|---|
| Tap Caps Lock | Switch to the previous window |
| Hold Caps Lock, tap Tab | Keep the switcher open and step through windows. Shift+Tab steps back, and the arrow keys work too |
| Release Caps Lock | Go to the selected window |
| Shift+Caps Lock | Turn real Caps Lock on or off |

## Setup

1. Install AutoHotkey v2:

   ```powershell
   winget install --id AutoHotkey.AutoHotkey -e
   ```

2. Double-click `CapsLockAltTab.ahk`. A green "H" icon in the notification area
   means it's running. Right-click that icon to pause or exit it.
3. Start it at sign-in:

   ```powershell
   powershell -ExecutionPolicy Bypass -File .\scripts\Set-Startup.ps1
   ```

   Undo with `-Remove`. The shortcut goes in your Startup folder (`shell:startup`).

## Limits

- Windows doesn't let a normal program send keys to an elevated (admin) window. While
  an admin window has focus, Caps Lock won't switch away from it. Running the script
  as admin fixes that, but isn't worth it for most people.
- If the script is killed while Caps Lock is held, Alt can stay held. Tap Alt to
  release it.

## Why AutoHotkey and not the Alps tray

It's a keyboard remap with nothing to do with the pointing stick, and AutoHotkey's
keyboard hook is built for this. Doing it in the PowerShell tray app would mean a
system-wide keyboard hook in a process that is sometimes busy running PowerShell,
which can delay every keystroke.

## License

MIT
