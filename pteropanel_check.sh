#!/bin/sh

# Standard Nagios plugin return codes.
STATUS_OK=0
STATUS_WARNING=1
STATUS_CRITICAL=2
STATUS_UNKNOWN=3

LATEST_VERSION=$(curl -s https://cdn.pterodactyl.io/releases/latest.json | grep panel | cut -d '"' -f 4)
CURRENT_VERSION=$(sed -nE "s/^\s*'version' => '(.*?)',$/\1/p" /var/www/html/pterodactyl/config/app.php)

if [ "$CURRENT_VERSION" != "$LATEST_VERSION" ]; then
	echo "$STATUS_CRITICAL pteropanel_updates - not running on the latest version"
	exit $STATUS_CRITICAL
else
	echo "$STATUS_OK pteropanel_updates - panel is up-to-date"
	exit $STATUS_OK
fi

echo "$STATUS_UNKNOWN pteropanel_updates - Script failed, manual intervention required."
exit $STATUS_UNKNOWN
