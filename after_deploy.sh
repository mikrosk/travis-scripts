#!/bin/bash -eux
# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -x: Display expanded script commands

API="https://api.bintray.com"
SUBJECT="freemint"
REPO="freemint"

# why do we need this, no clue...
sleep 15s

for f in .travis/*.zip
do
	curl \
    --request PUT \
    --user ${BINTRAY_USER}:${BINTRAY_API_KEY} \
    --header "Content-Type: application/json" \
    --data "{ \"list_in_downloads\": true }" \
    "${API}/file_metadata/${SUBJECT}/${REPO}/snapshots/$(basename $f)"
done
