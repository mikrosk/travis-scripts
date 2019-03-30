#!/bin/bash -eux
# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -x: Display expanded script commands

HERE="$(dirname "$0")"
. "$HERE/version.sh"

API="https://api.bintray.com"
SUBJECT="freemint"
REPO="freemint"
if [ -n "${VERSIONED+x}" ]
then
	PACKAGE_NAME="snapshots"
else
	if [ "$CPU_TARGET" = "prg" ]
	then
		PACKAGE_NAME="snapshots-usb4tos"
	else
		PACKAGE_NAME="snapshots-cpu"
	fi
fi

# why do we need this, no clue...
sleep 15s

for f in .travis/*.zip
do
	curl \
    --request PUT \
    --user ${BINTRAY_USER}:${BINTRAY_API_KEY} \
    --header "Content-Type: application/json" \
    --data "{ \"list_in_downloads\": true }" \
    "${API}/file_metadata/${SUBJECT}/${REPO}/${PACKAGE_NAME}/${LONG_VERSION}/$(basename $f)"
done
