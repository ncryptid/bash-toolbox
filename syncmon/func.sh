source var.sh

# Get information about the manufacturer, the model, the serial number, etc.
vendFunc() {
	  dmicecode | \
    awk '/$1/{i++}i==$2{print; exit}'
}

# Add collected information into the documentation file in the appropriate section
printFunc() {
	  sed -i -e "s|$1|& $2  |" $docName
    #	sed -i "s|\$2.*|$2|" $docName
}

# Sync to a server using rsync
syncFunc {
    rsync -aAXv "$PWD" $servDir
}
