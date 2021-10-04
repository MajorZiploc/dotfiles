#!/usr/bin/env bash

echo "Refreshing powershell modules...";
echo '';
pwsh -Command '& {@("powershell_scaffolder", "PSLogFileReporter") | ForEach-Object { Install-Module -Name "$_" -Scope CurrentUser -Force;}}';
echo '';
echo "Refresh completed.";

