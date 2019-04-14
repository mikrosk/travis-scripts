#!/bin/bash -eux
# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -x: Display expanded script commands

LIBCMINI_URL=$(curl -s https://api.github.com/repos/mfro0/libcmini/releases/latest | jq -r '.assets[].browser_download_url')
LIBCMINI_NAME=$(curl -s https://api.github.com/repos/mfro0/libcmini/releases/latest | jq -r '.assets[].name')

cd ..
mkdir libcmini
wget -q "$LIBCMINI_URL"
tar xzvf "$LIBCMINI_NAME" -C libcmini
cd -
