#!/bin/bash
clear
###
#
#	System Update v1.0.0
#
#	Lead Author: Lee Hodson
#	Donate: paypal.me/vr51
#	Website: https://journalxtra.com
#	First Written: 8th Jan. 2016
#	First Release: 8th Jan. 2016
#	This Release: 8th Jan. 2016
#
#	Copyright 2015 JournalXtra™
#	License: GPL3
#
#	Programmer: Lee Hodson <journalxtra.com>, Lee Hodson <vr51.com>
#
#	Use of this program is at your own risk
#
#	TO RUN:
#
#	- Ensure the script is executable.
#	- Command line: sh update.sh
#	- File browser: click update.sh
#
#	Use System Update to start apt-get update services.
#
###

###
#
#	Let the user know we are running
#
###

printf "SYSTEM UPDATE INITIALISED\n----------------------\n\n"

###
#
#	Set Variables
#
###

# Establish Linux epoch time in seconds
now=$(date +%s)

# Establish both Date and Time
todaytime=$(date +"%Y-%m-%d-%H:%M:%S")

# Locate Where We Are
filepath="$(dirname "$(readlink -f "$0")")"


###
#
#	Register leave_program function
#
###


leave_program() {

	exittime=$(date +%s)
	runtime=$(($exittime - $now))

	printf "\nPROGRAM RUN TIME: $runtime seconds\n"
	printf "\n\nPress any key to exit"
	read something
	exit

}


###
#
#	Confirm we are running in a terminal
#		If not, try to launch this program in a terminal
#
###

tty -s

if test "$?" -ne 0
then

	# This code section is released in public domain by Han Boetes <han@mijncomputer.nl>
	# Updated by Dave Davenport <qball@gmpclient.org>
	# Updated by Lee Hodson <https://journalxtra.com> - Added break on successful hit, added more terminals, humanized the failure message, replaced call to rofi with printf and made $terminal an array for easy reuse.
	#
	# This script tries to exec a terminal emulator by trying some known terminal
	# emulators.
	#
	# We welcome patches that add distribution-specific mechanisms to find the
	# preferred terminal emulator. On Debian, there is the x-terminal-emulator
	# symlink for example.

	terminal=( x-terminal-emulator xdg-terminal konsole gnome-terminal terminator urxvt rxvt Eterm aterm roxterm xfce4-terminal termite lxterminal xterm )
	for i in ${terminal[@]}; do
		if command -v $i > /dev/null 2>&1; then
			exec $i -e "$0"
			break
		else
			printf "\nUnable to automatically determine the correct terminal program to run e.g Console or Konsole. Please run this program from a terminal AKA the command line.\n"
			read something
			leave_program
		fi
	done

fi

###
#
#	Check for required software dependencies
#
###

printf "Checking software requirements...\n\n"
error=0
requirement=( apt-get )
for i in ${requirement[@]}; do

	if command -v $i > /dev/null 2>&1; then
		statusmessage+=("%4sFound:%10s$i")
		statusflag+=('0')
	else
		statusmessage+=("%4sMissing:%8s$i")
		statusflag+=('1')
		whattoinstall+=("$i")
		error=1
	fi

done

# Display status of presence or not of each requirement

for LINE in ${statusmessage[@]}; do
	printf "$LINE\n"
done

printf "\n"
# Check for critical errors

critical=0

if test ${statusflag[0]} = 1; then
		printf "%4sCritical:%6s apt-get is not installed. Program cannot run\n"
		critical=1
fi

# Display appropriate status messages

if test "$error" == 0 && test "$critical" == 0; then
	printf "The software environment is optimal for this program.\n\n"
fi

if test "$error" == 1 && test "$critical" == 0; then
	printf "Missing non essential software. If the program fails to run, consider to install with, for example,\n\n%6ssudo apt-get install ${whattoinstall[*]}\n\n"
fi

if test "$critical" == 1; then
	printf "Missing critical software. The program will not run. Install missing software with, for example,\n\n%6ssudo apt-get install ${whattoinstall[*]}\n\n"
	read something
	leave_program
fi


###
#
#	Obtain Authorisation to update the system
#
###

# Add event to run.log

printf "\n\nAUTHORISATION\n-------------\n"

printf "\nAuthorise System Update to update the system:\n"
sudo -v

###
#
#	Proceed with updates
#
###

sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade

printf "\nUPDATES COMPLETED\n"

prompt_confirm() {
  while true; do
    read -r -n 1 -p "${1:-Continue?} [y/n]: " REPLY
    case $REPLY in
      [yY])
		sudo apt-get clean
		sudo apt-get autoremove
		printf "Press any key to exit."
		read something
		leave_program
		;;

      [nN])
		leave_program
		;;

      *)
		printf "\033[31m %s \n\033[0m" "Answer 'y' to proceed or 'n' to exit."
    esac
  done
}

prompt_confirm "Clean the cache of downloaded packages and run autoremove?" || exit 0