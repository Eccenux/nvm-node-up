# Changelog

## v1.0

### Changes:
- [x] Base files and PoC.
- [x] Install packages from the previous version:
	- [x] Impl `nvm-up globals-list`.
	- [x] Impl `nvm-up globals-install`.
- [ ] split to psm1? (each case of switch as a separate function? return instead of exit?)
- [ ] Impl `nvm-up up X`:
	- [ ] `nvm-up up X` – specific version.
	- [ ] `nvm-up up`  – interactive mode (list and choose).

### Docs and info:
- [x] Help create a $PROFILE file (create dir, create file, open to edit xor append?).
- [x] Main docs linking to others.
- [x] Hopes and dreams aka changelog.
- [ ] List of available commands: `./docs/commands.md`.
- [ ] Getting Started
	- [ ] Quick list of commands syntax.
	- [ ] Link to `./docs/commands.md`.

### Extras/maybe
- [ ] Main improvements (main as in running `nvm-up` without any options)
	- [ ] List available commands (from `./docs/commands.md`? or should that be reserved to `nvm-up help`? or should there be `./docs/commands-long.md`?).
	- [ ] Help choose what to update.
		- [ ] Function to get the latest version of a given major Node version.
		- [ ] List latest versions for each installed version (parse `nvm list`? and use the above function).
		- [ ] Show a list of installed versions and latest versions.
		- [ ] Indicate if the installed version is the latest / can be updated.
- [ ] Cache of the Node list: https://nodejs.org/dist/index.json
	(seems like it's not always available, not for nvm at least)
	(connectex: A connection attempt failed because the connected party did not properly respond after a period of time, or the established connection failed because the connected host has failed to respond.)
- [ ] Get latests from a dir instead? E.g. https://nodejs.org/dist/latest-v22.x/
- [ ] Impl of `list` command?
	- (kind of equivalent of `nvm list available`, but show more details and shorter at the same time)
	- Find latest versions from latest major Nodejs versions.
	- Dump as a table, see [Notes](./notes.md#node-versions).
	- `list 16` show a more detailed view of 16 major.
	- `list 16.1` show a more detiled view of 16.1.
- [ ] `nvm-up gi`: add option to skip questions: --force=(exact|same|latest)
- [ ] `nvm-up gi`: filter out already installed?
	- Could get a fresh list to variable directly:
		$jsonContent = & npm list -g --depth=0 --json | ConvertFrom-Json
	- Then get just the names and skip them.
	- ...BUT is it OK?
		I might want to run `nvm-up gi` many times and overwrite what is already installed.
		I could just skip exact matches...
		Or I could make this optional... maybe.
- [ ] `nvm-up gi`: list already installed side-by-side with the ones from json?
- [ ] .
- [ ] .

### Commands of nvm-up:

#### `nvm-up globals-list`
Is almost the same as: `npm list -g --depth=0 --json > global-modules.temp.json`
```
	aliasses: "gl", "glist", "g-list"
	param: --to=global-modules.temp.json [optional]
	Info:
		- Global modules list ({count}) saved as {path}.
		- You can now install a new Node version.
```

#### `nvm-up globals-install` -- install from global-modules.temp.json
```
	aliasses: "gi", "ginstall", "g-install"
	param: --from=global-modules.temp.json [optional]
	Lists globals:
		├── corepack@0.31.0 (omitted already installed) <-- do we want to omit?
		├── npm@10.8.2 (omitted already installed) <-- do we want to omit?
		├── eslint@9.22.0
		├── gulp-cli@3.0.0
		├── mocha@11.1.0
		├── svgo@3.4.2
		└── wiki-to-git@1.1.1
	Asks which versions of modules you want:
		- the same packages (i.e. `svgo@3.4.2`)
		- same major (i.e. `svgo@3`)
		- latest versions (i.e. `svgo`)
```

#### `nvm-up up X` (e.g. X=lts)

Flow:
- verOld = get current Node version
- `globals-list`
- `nvm install X` (e.g. `nvm install lts`)
- `nvm use X`
- `globals-install`

Info:
```
Info: If you want to remove the old version, run:
`nvm uninstall {verOld}`
```