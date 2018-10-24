#!/bin/bash

# A simple script to backup to a remote server using rsync and record it. This will later be replaced with duplicity (http://duplicity.nongnu.org/)

# What to backup, to where, using which user on the server with what ssh port
# Make sure to fill these out
fromDir=""
servUser=""
servHost=""
servPort=""
toDir=""
emailName=""
emailHost=""

bkFunc() {
    rsync -aAXxv -e "ssh -p $servPort -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"}  --progress $fromDir $servUser@$servHost:$toDir

# Record the last time a backup ran to bashrc
sed -i "s/d=\".*\"/d=\"$(date)\"/g" ~/.bashrc

# Send email if failure
if [ $ERR -eq 1 ] ; then
   echo 'rsync failure' | /usr/bin/mailx -s 'rsync error' $emailName@$emailHost
fi
}

# Call function and output stdout and stderror to a log file
bkFunc >> /var/log/rsync.log  2>&1
