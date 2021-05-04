#!/bin/sh

# Standard Nagios plugin return codes.
STATUS_OK=0
STATUS_WARNING=1
STATUS_CRITICAL=2
STATUS_UNKNOWN=3

LATEST_VERSION=$(curl -s https://cdn.pterodactyl.io/releases/latest.json | grep wings | cut -d '"' -f 4)
CURRENT_VERSION=$(/usr/local/bin/wings version)

CV1=$(echo $CURRENT_VERSION | awk -F"v" '{ print $2 }')
CV2=$(echo $CV1 | awk -F" " '{ print $1 }')

CURRENT_VERSION=$(echo $CV2)
if [ "$CURRENT_VERSION" != "$LATEST_VERSION" ]; then
        echo "$STATUS_CRITICAL pterowings_updates - not running on the latest version"
        exit $STATUS_CRITICAL
else
        echo "$STATUS_OK pterowings_updates - panel is up-to-date"
        exit $STATUS_OK
fi

echo "$STATUS_UNKNOWN pterowings_updates - Script failed, manual intervention required."
exit $STATUS_UNKNOWN

