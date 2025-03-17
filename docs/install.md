This script that allows managing Node updates over nvm.

1. Download the script.
2. Make it available in PS.
3. Run `nvm-up` and have a fruitful day 🚀

## Make it available in PS

You could just run `nvm-up.ps1` by providing the full path, but that's less convenient.

Creating a PS profile will make a command available for you anywhere.  

### Creat your profile

Check if you already have a generic PS profile:
```powershell
dir "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
```

Edit your PowerShell profile:
```powershell
$main_profile="$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
Write-Host "Creating: $main_profile"
# Check your profile path:
if (!(Test-Path -Path $main_profile)) {
	New-Item -ItemType File -Path $main_profile -Force
}
# Open in Notepad
notepad $main_profile
```
Add the function in your profile (wherever should be fine):
```powershell
function nvm-up { & "C:\Program Files\nvm-up\nvm-up.ps1" @args }
```
Reload the profile:
```powershell
. $main_profile
```

This ensures `nvm-up` is recognized as a command in every PowerShell session.

### Unlock your profile

PowerShell is super careful for normal humans, but as a super human (aka dev 😉) you probably don't need to worry about it too much.

```powershell
# Permanent unlock of ps1 scripts:
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
```
