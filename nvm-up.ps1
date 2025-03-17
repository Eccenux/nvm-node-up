<#
	This script allows managing Node updates over nvm.

	Author: Maciej Nux Jaros
#>

param (
	[string]$command,
	[string]$to = "global-modules.temp.json"
)

$nvmPath = "$env:NVM_HOME\nvm.exe"
$npmPath = "npm"

if (-Not (Test-Path $nvmPath)) {
	Write-Host "Error. NVM is not installed or NVM_HOME is not set. Exiting." -ForegroundColor Red
	exit 1
}

# Default: Show nvm list
if (-Not $command) {
	$command = "list"
}

# Aliases
if ($command -in "gl", "glist", "g-list") {
	$command = "globals-list"
}

##
# Commands
##
switch ($command) {
	# Enhanced nvm list
	"list" {
		& $nvmPath list
		exit 0
	}

	# List globally installed modules and save the output as JSON
	"globals-list" { 
		$outputFile = Join-Path (Get-Location) $to

		Write-Host "Fetching global modules list..."
		& $npmPath list -g --depth=0 --json | Out-File -Encoding utf8 $outputFile

		# Count global packages
		$jsonContent = Get-Content $outputFile -Raw | ConvertFrom-Json
		$filteredModules = $jsonContent.dependencies.PSObject.Properties.Name | Where-Object { $_ -ne "corepack" -and $_ -ne "npm" }
		$moduleCount = $filteredModules.Count

		Write-Host "Global modules list ($moduleCount) saved as $outputFile." -ForegroundColor Green
		Write-Host "You can now install a new Node version."

		exit 0
	}

	default {
		Write-Host "Unknown command: $command" -ForegroundColor Red
		exit 1
	}
}
