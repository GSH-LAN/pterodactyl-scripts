#!/bin/bash

LATEST_VERSION=$(curl -s https://api.github.com/repos/pterodactyl/wings/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
CURRENT_VERSION=$(/usr/local/bin/wings --version)

if [ "$CURRENT_VERSION" != "$LATEST_VERSION" ]; then
	sudo curl -L -o /usr/local/bin/wings https://github.com/pterodactyl/wings/releases/download/v$LATEST_VERSION/wings_linux_amd64
	sudo chmod u+x /usr/local/bin/wings
	sudo systemctl restart wings
fi
