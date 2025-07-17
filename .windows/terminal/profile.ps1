#!/usr/bin/env powershell
# C:\Windows\System32\WindowsPowerShell\v1.0\profile.ps1
# @egirlcatnip

# Set XDG directories
# not applicable

# Native prompt
function global:prompt {
    $user = [System.Environment]::UserName.ToLower()
    $hostname = [System.Environment]::MachineName.ToLower()
    $cwd = $(Get-Location).Path

    Write-Host "$user@$hostname | pwsh"
    Write-Host "$cwd" -ForegroundColor "Blue"
    Write-Host "$" -ForegroundColor "Green" -NoNewline
    " "
}

function Initialize-Starship {
  if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (& starship init powershell)
  }
}

function Initialize-Zoxide {
  if (Get-Command zoxide -ErrorAction SilentlyContinue) {
   Invoke-Expression (& { (zoxide init powershell | Out-String) })
  }
}

function Configure-InteractiveShell {
  Initialize-Starship
  Initialize-Zoxide
}

function Configure-NonInteractiveShell {
  ;
}
if ($Host.Name -match 'ConsoleHost') {
  Configure-InteractiveShell
}
else {
  Configure-NonInteractiveShell
}

