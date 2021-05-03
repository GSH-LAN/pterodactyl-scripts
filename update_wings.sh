#!/bin/bash

#LATEST_VERSION=$(curl -s https://api.github.com/repos/pterodactyl/wings/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
LATEST_VERSION=$(curl -s https://cdn.pterodactyl.io/releases/latest.json | grep wings | cut -d '"' -f 4)
CURRENT_VERSION=$(/usr/local/bin/wings version)

CV1=$(echo $CURRENT_VERSION | awk -F"v" '{ print $2 }')
CV2=$(echo $CV1 | awk -F" " '{ print $1 }')

CURRENT_VERSION=$(echo $CV2)
if [ "$CURRENT_VERSION" != "$LATEST_VERSION" ]; then
	curl -L -o /usr/local/bin/wings https://github.com/pterodactyl/wings/releases/download/v$LATEST_VERSION/wings_linux_amd64
	chmod u+x /usr/local/bin/wings
	sudo systemctl restart wings
fi
