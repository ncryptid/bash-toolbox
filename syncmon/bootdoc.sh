#!/bin/bash

# Script to be run on boot to collect information that should not be changing between reboots like system hardware and kernel/hostname

source var.sh
source func.sh

# Create a configuration file for the system from the template if it doesn't exist
# Optionally if the "rm" argument is supplied, delete the current doc and regen

if [ $1 = "rm" ]; then
	  rm $docName
fi

if [ ! -f ./$docName ]; then
	  cp doctemplate.md $docName
fi


printFunc Hostname: "$hostVar"
printFunc OS: "$osVar"
printFunc Kernel: "$kVar"

printFunc CPU: "$cpuVar"
printFunc Cores: "$coreVar"
printFunc RAM: "$memVar"

