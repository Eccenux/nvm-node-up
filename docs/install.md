This script that allows managing Node updates over nvm.

1. Download the script.
2. Make it available in PS.
3. Run `nvm-up` and have a fruitful day 🚀

## 1) Download the script

For easier updates, you can clone this repository to `C:\Program Files\nvm-up\`.

You can also just download `nvm-up.ps1` and put it in `C:\Program Files\nvm-up\nvm-up.ps1`.

## 2) Make it available in PS

You could just run `nvm-up.ps1` by providing the full path, but that's less convenient.

Creating a PS profile will make a command available for you anywhere.  

### Creat your profile

Check if you already have a generic PS profile (execute this in Powershell as from your standard user account):
```powershell
dir "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
```

Create your PowerShell profile:
```powershell
$main_profile="$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
Write-Host "Creating: $main_profile"
# Check your profile path:
if (!(Test-Path -Path $main_profile)) {
	New-Item -ItemType File -Path $main_profile -Force
}
```
Edit your PowerShell profile:
```powershell
# Open in Notepad
notepad $main_profile
```
Add the function in your profile (e.g. add it at the end of file):
```powershell
function nvm-up { & "C:\Program Files\nvm-up\nvm-up.ps1" @args }
```
If it's not obvious — you can change the path above to wherever you placed your copy of `nvm-up.ps1`.

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

## 3) Using nvm-up

### Prepare and install new Node
```Powershell
# Save a list of current global modules
# (uses a temp file in current dir)
nvm-up globals-list
# install new version, e.g. latest LTS:
nvm install lts
```

### Switch and restore
```Powershell
# swtich to new (nvm install should tell you what was installed)
# (version 22.17 is obviously just an example)
nvm use 22.17.0
```
```Powershell
# Restore global modules
# (this will use a file generated with globals-list)
# (a list will be shown, and you will be given a choice of installation type)
nvm-up globals-install
```
