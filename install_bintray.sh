#!/bin/bash -eux
# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -x: Display expanded script commands

CURL_USER="${BINTRAY_USER}:${BINTRAY_API_KEY}"
SYSROOT_DIR=${SYSROOT_DIR:-"/usr/m68k-atari-mint/sys-root/usr"}
BINTRAY_REPO=${BINTRAY_REPO:-"lib"}

sudo mkdir -p "${SYSROOT_DIR}" && cd "${SYSROOT_DIR}"

for package in $*
do
	unset PACKAGE_VERSION
	unset PACKAGE_PATH
	PACKAGE_VERSION=$(curl -s -u "${CURL_USER}" -X GET "https://api.bintray.com/packages/freemint/$BINTRAY_REPO/$package" | jq -r '.latest_version')
	read PACKAGE_PATH \
		<<< $(curl -s -u "${CURL_USER}" -X GET "https://api.bintray.com/packages/freemint/$BINTRAY_REPO/$package/versions/$PACKAGE_VERSION/files" \
			| jq -r '.[].path')
	wget -q -O - "https://dl.bintray.com/freemint/$BINTRAY_REPO/$PACKAGE_PATH" | sudo tar xjf -
done
