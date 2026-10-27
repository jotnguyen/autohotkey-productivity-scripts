<#
.SYNOPSIS
  Starts CapsLockAltTab.ahk at sign-in, or stops starting it, with a shortcut in the
  current user's Startup folder.
.DESCRIPTION
  Creates or removes "CapsLockAltTab.lnk" in shell:startup, pointing at the .ahk file
  next to this folder. AutoHotkey v2 has to be installed so .ahk files open with it.
  Needs no admin rights. Supports -WhatIf.
.PARAMETER Remove
  Delete the shortcut instead.
.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\scripts\Set-Startup.ps1
.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\scripts\Set-Startup.ps1 -Remove
#>
[CmdletBinding(SupportsShouldProcess)]
param([switch]$Remove)
$ErrorActionPreference = 'Stop'

$ahk = Join-Path (Split-Path $PSScriptRoot -Parent) 'CapsLockAltTab.ahk'
$lnk = Join-Path ([Environment]::GetFolderPath('Startup')) 'CapsLockAltTab.lnk'

if ($Remove) {
  if (-not (Test-Path $lnk)) { Write-Output 'No startup shortcut. Nothing to do.'; return }
  if ($PSCmdlet.ShouldProcess($lnk, 'delete the startup shortcut')) {
    Remove-Item $lnk
    Write-Output 'Removed. CapsLockAltTab no longer starts at sign-in.'
  }
  return
}

if (-not (Test-Path $ahk)) { throw "Script not found: $ahk" }
if ($PSCmdlet.ShouldProcess($lnk, "create a startup shortcut to $ahk")) {
  $sh = New-Object -ComObject WScript.Shell
  $s = $sh.CreateShortcut($lnk)
  $s.TargetPath = $ahk
  $s.WorkingDirectory = Split-Path $ahk -Parent
  $s.Description = 'Caps Lock = Alt+Tab'
  $s.Save()
  Write-Output "Created $lnk"
}
