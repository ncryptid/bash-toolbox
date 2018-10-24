#!/bin/bash

#Define variables foer the hostname, the name of the documentation file, the OS, and the kernel
hostVar=$(hostname)
docName=$(hostname)-doc.md
osVar=$(uname -o)
kVar=$(uname -rv)

# Define variables for the primary interface, the interfaces list, and the primary interface's IP
ifaceVar=$(route | tail -n 1 | cut -d" " -f36)
ifacelsVar=$(ip link show | cut -d" " -f2 | sed -e "s/://g")
lanipVar=$(ip addr show $ifaceVar | grep -Po 'inet \K[\d.]+')
wanipVar=$(curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//')

# Define variables for the physical disks and the physical filesystems
dskVar=$(lsblk | grep disk)
fsVar=$(df -lh)
totVar=$(df -lh --total | tail -n 1)

# Define variables for CPU type, cores, and available memory
cpuVar=$(lscpu | grep "Model name:" | sed "s/.*name:*//" | sed -e "s/^[[:space:]]*//")
coreVar=$(cat /proc/cpuinfo | grep processor | wc -l)
memVar=$(free -mh | grep Mem | cut -d' ' -f11)

# Define where to send off the documentation to
servDir=""
