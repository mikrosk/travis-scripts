#!/bin/bash -eux
# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -x: Display expanded script commands

CURL_HEADER="Authorization: token $GITHUB_OATH_TOKEN"

LIBCMINI_URL=$(curl -s -H "$CURL_HEADER" https://api.github.com/repos/mfro0/libcmini/releases/latest | jq -r '.assets[].browser_download_url')
LIBCMINI_NAME=$(curl -s -H "$CURL_HEADER" https://api.github.com/repos/mfro0/libcmini/releases/latest | jq -r '.assets[].name')

cd ..
mkdir libcmini
wget -q "$LIBCMINI_URL"
tar xzvf "$LIBCMINI_NAME" -C libcmini
cd -

QED_URL=$(curl -s -H "$CURL_HEADER" https://api.github.com/repos/freemint/freemint.github.io/contents/builds/qed/master | jq -r '.[].download_url')
QED_NAME=$(curl -s -H "$CURL_HEADER" https://api.github.com/repos/freemint/freemint.github.io/contents/builds/qed/master | jq -r '.[].name')

cd .travis
wget -q "$QED_URL"
unzip "$QED_NAME"
rm "$QED_NAME"
cd -
