#!/bin/bash

# Script to be run periodically while the system is running to update things that may be changing like the IP addresses

source var.sh
source func.sh

printFunc 'Primary interface:' "$ifaceVar"
printFunc LAN: "$lanipVar"
printFunc WAN: "$wanipVar"

syncFunc
