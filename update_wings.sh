#!/bin/bash

LATEST_VERSION=$(curl -s -S https://api.github.com/repos/pterodactyl/wings/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-) > /dev/null
CURRENT_VERSION=$(/usr/local/bin/wings version | head -n 1 | cut -d'v' -f2-)

if [ "$CURRENT_VERSION" != "$LATEST_VERSION" ]; then
        echo "Wings is not up to date! installed: $CURRENT_VERSION  available: $LATEST_VERSION"
        sudo curl -s -S -L -o /usr/local/bin/wings https://github.com/pterodactyl/wings/releases/download/v$LATEST_VERSION/wings_linux_amd64
        sudo chmod u+x /usr/local/bin/wings
        sudo systemctl restart wings
else
        echo "Wings version $CURRENT_VERSION is up to date!"
fi
