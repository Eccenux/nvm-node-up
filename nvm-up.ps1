<#
	This script that allows managing Node updates over nvm.
#>

$nvmPath = "$env:NVM_HOME\nvm.exe"

if (-Not (Test-Path $nvmPath)) {
    Write-Host "Error. NVM is not installed or NVM_HOME is not set. Exiting." -ForegroundColor Red
    exit 1
}

# Run 'nvm list' and display the output
& $nvmPath list
