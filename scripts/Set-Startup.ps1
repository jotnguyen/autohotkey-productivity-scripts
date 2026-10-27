<#
.SYNOPSIS
  Starts one of this repo's .ahk scripts at sign-in, or stops starting it, with a
  shortcut in the current user's Startup folder.
.DESCRIPTION
  Creates or removes "<script name>.lnk" in shell:startup, pointing at the .ahk file
  in the repo root. AutoHotkey v2 has to be installed so .ahk files open with it.
  Needs no admin rights. Supports -WhatIf.
.PARAMETER Script
  The .ahk file in the repo root. Defaults to CapsLockAltTab.ahk.
.PARAMETER Remove
  Delete the shortcut instead.
.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\scripts\Set-Startup.ps1
.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\scripts\Set-Startup.ps1 -Script Cascade-Win.ahk
.EXAMPLE
  powershell -ExecutionPolicy Bypass -File .\scripts\Set-Startup.ps1 -Remove
#>
[CmdletBinding(SupportsShouldProcess)]
param(
  [string]$Script = 'CapsLockAltTab.ahk',
  [switch]$Remove
)
$ErrorActionPreference = 'Stop'

$ahk = Join-Path (Split-Path $PSScriptRoot -Parent) $Script
$name = [IO.Path]::GetFileNameWithoutExtension($Script)
$lnk = Join-Path ([Environment]::GetFolderPath('Startup')) "$name.lnk"

if ($Remove) {
  if (-not (Test-Path $lnk)) { Write-Output 'No startup shortcut. Nothing to do.'; return }
  if ($PSCmdlet.ShouldProcess($lnk, 'delete the startup shortcut')) {
    Remove-Item $lnk
    Write-Output "Removed. $name no longer starts at sign-in."
  }
  return
}

if (-not (Test-Path $ahk)) { throw "Script not found: $ahk" }
if ($PSCmdlet.ShouldProcess($lnk, "create a startup shortcut to $ahk")) {
  $sh = New-Object -ComObject WScript.Shell
  $s = $sh.CreateShortcut($lnk)
  $s.TargetPath = $ahk
  $s.WorkingDirectory = Split-Path $ahk -Parent
  $s.Description = $name
  $s.Save()
  Write-Output "Created $lnk"
}
