# Ubuntu/Debian Linux Software Update Script
Simple Bash script to sit on the desktop. Mostly a wrapper for frequently used apt-get command sequences but with bonus system repair tools. When clicked, the softman script runs apt-get update, upgrade, dist-upgrade, full-upgrade and clean. Other run options are described below.

* You only need to download the file 'softman'.
* Make the file executable (desktop users: right-click then select 'executable')
* Click the file to run software updates
* Read Features section of this readme to learn the commandline options.

I keep the script on my desktop so I can click it any time I want to check for updates and install them without need to type various apt-get sequences.

## Features

* Adds, removes and lists installed repositories.
* Finds available software pacakges.
* Updates the system when clicked.
* Accepts commandline arguments.
* Will execute 'softman upgrade' when clicked
* Can be run from the command line with arguments passed to it
* Can be included within another script as a source file (with minor changes. The library version is slightly different).

## Commandline Options

- upgrade: update/upgrade the system software with suggested build dependent packages
- list: show installed repositories.
- add: add a repository
- remove: remove a repository but keep software installed from the repository
- purge: remove a repository and remove sotware installed from the repository, install alternate software version if available in another installed repository.
- find: find software
- install: install software with suggested build dependent packages
- reinstall: reinstall software with suggested build dependent packages
- fix: fix broken packages and configure any partially installed software
- findbad: find packages with corrupt files / find packages with missing files
- fixbad: find currupt software and automatically reinstall their packages. Use with caution.
- fixmissing: find software with missing files and automatically reinstall their packages. Use with caution.
- rebuildsystem: reinstall all installed software. Use with extreme caution.
- build: download package source files and compile into a .deb binary file ready for installation
- flush: clear the download cache and automatically remove packages that are no longer required.

## Commandline Option Flags

- -u: Run apt-get update
- -h: Show helpfile
- -v: Show version number

## Usage

Use 'softman list' to list installed repositories.

```
sudo ./softman list
```

Use 'softman add' to add a repository. Multiple repositories can be added at the same time, e.g,

```
sudo ./softman add ppa:florian-rival/gdevelop
```

Use 'softman remove' to remove a repository. Multiple repositories can be added at the same time, e.g,

```
sudo ./softman remove ppa:florian-rival/gdevelop
```

Use 'softman purge' to remove a repository, to remove software installed from the repository and to install alternate software versions of removed software if those versions are available. Multiple repositories can be added at the same time, e.g,

```
sudo ./softman purge ppa:florian-rival/gdevelop
```

Use 'softman find' to search for software available in the installed repositories, e.g,

```
sudo ./softman find gimp php* alsa*
```

Use 'softman install' and 'softman reinstall' as you would apt-get install, i.e. list packages after the command, e.g.

```
sudo ./softman install vlc gimp kate
```
and
```
sudo ./softman reinstall vlc gimp kate
```

Use 'softman fix' to fix broken packages and to configure any partially installed software, e.g,

```
sudo ./softman fix
```
## The following commands are safe to use but exercise caution
Use 'softman findbad' to list corrupt files, e.g,

```
sudo ./softman findbad
```

Use 'softman fixbad' to repair/replace corrupt files, e.g,

```
sudo ./softman fixbad
```

Use 'softman fixmissing' to replace missing software files, e.g,

```
sudo ./softman fixmissing
```

The following command will either fix or destroy your system. Should be safe to use but.. there is always risk!
```
sudo ./softman rebuildsystem
```
# History
This began as a simple system update script to keep on the desktop and click to quickly run system software updates. Now it is so much more.

SoftMan (Software Manager) is part of a library of scripts I wrote and frequently use in Linux projects. This library will soon be released on Github for others to make use of in their own Bash projects.

The update script released to this Github repo is a selfcontained version of an update and software (re)installation script. It is mostly a wrapper for frequently used apt-get command sequences but also includes commands to automatically reinstall software packages that contain corrupt files (e.g. after hardware crash, malware infection or self-inflicted damage when a script runs amock).

# Why?
Because opening a terminal to run updates is too much hassle and I'm too lazy to use GUI options that take forever to load. Plus, I needed an update library and installer for other scripts.
