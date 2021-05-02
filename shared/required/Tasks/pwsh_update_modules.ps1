#!/bin/bash

$dirs = @(
  "~/Documents/WindowsPowerShell/Modules"
  "~/Documents/PowerShell/Modules"
  "~/OneDrive/Documents/WindowsPowerShell/Modules"
  "~/OneDrive/Documents/PowerShell/Modules"
)

$dirs | ForEach-Object {
  if (Test-Path -Path "$_") {
    cd "$_"
    Write-Host "----------------------"
    Write-Host "Refreshing repos in $_"
    Write-Host "----------------------"
    ls -Directory | ForEach-Object {
      Write-Host $_.Name
      cd $_.Name
      git checkout master && git pull
      cd ..
    }
    Write-Host ""
    cd ..
  }
}



