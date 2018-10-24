#!/bin/bash

# This script uses nmap, ipscan, and standard Unix tools to programmatically get network information
# and then use this network information to scan the local network for all hosts and ip addresses.
# The script could be extended further by piping the output into grep to exclude everything that doesn't have
# a hostname if looking specifically for computers on the network.

# Get the primary IP and the subnet mask, save to variables 
# Calculate the network range using ipcalc, save to variable

prip="$(route | tail -n 1 | cut -d' ' -f1)"
smask="$(route | tail -n 1 | cut -d' ' -f15)"
netrange="$(ipcalc $prip/$smask | grep Network | cut -d' ' -f4)"

# Use the network range with nmap to scan the local network for hosts and their IP addresses

sudo nmap -sn $netrange | \
	grep report | \
	sed 's/^.*for/for/' | \
	sed 's/for //g'
