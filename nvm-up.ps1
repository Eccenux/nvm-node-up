<#
	This script allows managing Node updates over nvm.

	Author: Maciej Nux Jaros
#>

param (
	[string]$command,
	[string]$to = "global-modules.temp.json",
	[string]$from = "global-modules.temp.json"
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
if ($command -in "gi", "ginstall", "g-install") {
	$command = "globals-install"
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

	# List globally installed modules and save the output to a JSON files
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

	# Install global modules from a different installation (modules list read from JSON)
	"globals-install" {
		$inputFile = Join-Path (Get-Location) $from

		if (-Not (Test-Path $inputFile)) {
			Write-Host "Error: File $inputFile not found. Run 'nvm-up globals-list' first." -ForegroundColor Red
			exit 1
		}

		# Read JSON file and extract dependencies
		$jsonContent = Get-Content $inputFile -Raw | ConvertFrom-Json
		$dependencies = $jsonContent.dependencies.PSObject.Properties | Where-Object { $_.Name -ne "corepack" -and $_.Name -ne "npm" }

		if ($dependencies.Count -eq 0) {
			Write-Host "No global modules found in $inputFile." -ForegroundColor Yellow
			exit 0
		}

		Write-Host "Global modules found:" -ForegroundColor Cyan

		# Display modules for selection
		$installOptions = @()
		$lastDep = $dependencies[-1]
		foreach ($dep in $dependencies) {
			$name = $dep.Name
			$version = $dep.Value.version
			$nv = [string]::Format('{0}@{1}', $name, $version)
			if ($dep -eq $lastDep) {
				Write-Host ([string]::Format(' └── {0}', $nv))
			} else {
				Write-Host ([string]::Format(' ├── {0}', $nv))
			}
			$installOptions += $nv
		}

		# Ask user for install preference
		Write-Host "`nSelect installation type:" -ForegroundColor Yellow
		Write-Host " [1] Install exact versions (e.g., svgo@3.4.2)"
		Write-Host " [2] Install same major versions (e.g., svgo@3)"
		Write-Host " [3] Install latest versions (e.g., svgo)"
		$choice = Read-Host "Enter option (1-3)"

		$installCommand = "npm install -g "
		switch ($choice) {
			"1" { $installCommand += ($installOptions -join " ") }
			"2" { $installCommand += ($installOptions -replace "(@\d+)\.\d+\.\d+", '$1') -join " " }
			"3" { $installCommand += ($dependencies.Name -join " ") }
			default { 
				Write-Host "Invalid option. Aborting." -ForegroundColor Red
				exit 1
			}
		}

		# Run the npm install command
		Write-Host "`nDoes this seem OK?" -ForegroundColor Yellow
		Write-Host "$installCommand"
		$choice = Read-Host "Execute? ([y]/n)"
		if ($choice -in "n", "no", "exit", "q", "quit", "c", "cancel") {
			Write-Host "Aborting." -ForegroundColor Yellow
			exit 1
		}		
		Write-Host "`nInstalling selected packages..."
		Invoke-Expression $installCommand
		Write-Host "Installation completed." -ForegroundColor Green

		exit 0
	}

	default {
		Write-Host "Unknown command: $command" -ForegroundColor Red
		exit 1
	}
}
