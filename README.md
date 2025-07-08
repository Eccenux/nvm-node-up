# nvm-node-up

Welcome to **nvm-node-up**! This script allows you to manage **Node updates over nvm** on Windows. Crucially, it enables copying modules from an installed version to a new one. The provided PowerShell command is `nvm-up`.

Below, you'll find information on how to get started, along with links to more details about *nvm-node-up*.

**PRE RELEASE NOT FOR GENERAL USE**.

## 📌 Documentation

- [Installation Guide](./docs/install.md) – Steps to install and set up the project.
- [Changelog](./docs/changelog.md) – See what's new and what's cooking.
- [Notes](./docs/notes.md) – <del>Developer notes. Might be a bit chaotic</del>.

## 🚀 Getting Started

Refer to the [Installation Guide](./docs/install.md) for setup instructions.

Basically:
1. Download the script.
2. Make it available in PS.
3. Run `nvm-up` and have a fruitful day 🚀

## 🧪 Basic usage

Again, this is a pre-release... But this should work:

```Powershell
# Save a list of current global modules
# (uses a temp file in current dir)
nvm-up globals-list
# install new version, e.g. latest LTS:
nvm install lts
```
```Powershell
# swtich to new (nvm install should tell you what was installed)
nvm use 22.17.0
```
```Powershell
# Restore global modules
# (this will use a file generated with globals-list)
# (a list will be shown, and you will be given a choice of installation type)
nvm-up globals-install
```

## 💡 Contributing

Contributions <del>are</del> will be welcome! When v1 is done...

<del>Please add an issue or a pull request and explain changes you would like to see<del>.

## 📜 License
<img src="./docs/cc-logo.svg" width="20" alt="CC"> <img src="./docs/cc-by.svg"  width="20" alt="BY">
- Author: Maciej Nux Jaros
- License: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)<br>


