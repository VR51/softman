# Ubuntu/Debian Linux Software Update, Software Manager, .deb Builder & OS (Software) Repair Tool
Simple program to put on your desktop to click to run system updates. Softman is mostly a wrapper for frequently used apt-get command sequences but has several bonus tools such as system software repair tools and a .deb template creator.

When clicked, Softman will run apt-get update, upgrade, dist-upgrade, full-upgrade and clean. Other run options are described below.

Choose whether to install the program as a system file or whether to use the program without installation.

## The Installed Version

* Download the .deb file with the highest version number
* Click the softman-x.x.x.deb file to run the installer (where x.x.x is the version number)
* Softman will be installed into your computer ready for use like any other program or system command
* Softman is typically added to the Applications > Utilities menu.
* Click the softman icon to run software updates.
* Other options need to be run from the command line (Terminal).

To add softman to your taskbar, search for the program by typing 'softman' into your application launcher (e.g. Kicker) then right-click the icon to pin softman to your taskbar.

Read the Features section of this readme to learn the commandline options or type 'man softman' after installation.

## The Non Installed Version

* Download the file 'softman'.
* Make the file executable (desktop users: right-click then select 'executable')
* Click the file to run software updates
* Read the Features section of this readme to learn the commandline options.

## Features

* Adds, removes and lists installed repositories.
* Finds available software pacakges.
* Updates the system software when clicked (this is the same as 'softman upgrade').
* Accepts commandline arguments.
* Can be run from the command line with arguments passed to it.
* Can be included within other scripts as a source file (with minor changes. The library version is slightly different).
* Can be used to create a .deb template directory (complete with control, man and application desktop files) and to build the directoy into a .deb installer.

## Commandline Options

BASIC

- upgrade: update/upgrade the system software with suggested build dependent packages

REPOSITORY MANAGEMENT

- list: show installed repositories.
- add: add a repository
- remove: remove a repository but keep software installed from the repository
- purge: remove a repository and remove sotware installed from the repository, install alternate software version if available in another installed repository.

SOFTWARE MANAGEMENT

- find: find software
- install: install software with suggested build dependent packages
- reinstall: reinstall software with suggested build dependent packages
- package: create basic template directory ready for .deb package installer creation.
- build: download package source files and compile into a .deb binary file ready for installation
- flush: clear the download cache and automatically remove packages that are no longer required.

SYSTEM REPAIR TOOLS

- fix: fix broken packages and configure any partially installed software
- findbad: find packages with corrupt files / find packages with missing files
- fixbad: find currupt software and automatically reinstall their packages. Use with caution.
- fixmissing: find software with missing files and automatically reinstall their packages. Use with caution.
- rebuildsystem: reinstall all installed software. Use with extreme caution.

## Commandline Option Flags

- -u: Run apt-get update
- -h: Show helpfile
- -v: Show version number

## Usage

This guide assumes you are using the non installed version of Softman.

If you installed Softman with the .deb pacakge you must use these commands without the ./ infront of 'softman' e.g. 'softman list' instead of './softman list'.

Use 'softman list' to list installed repositories.

```
./softman list
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
./softman find gimp php* alsa*
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

Use 'softman package' to create a template directory ready for script files to be built into a .deb installer. Template consists of the basic necessary debian package directories, the control file, the desktop application file and the man file. 'softman package' also builds the final .deb package.

```
./softman package
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

## Why?
Because opening a terminal to run updates is too much hassle and I'm too lazy to use GUI options that take forever to load. Plus, I needed an update library and installer for other scripts.

# Changelog

1.0.7

- Added 'softman package' feature to build .deb installers.
