#!/bin/bash -eux
# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -x: Display expanded script commands

if [ "${TRAVIS_PULL_REQUEST}" = "false" -a "${TRAVIS_REPO_SLUG}" = "freemint/freemint" ]
then
	CURL_HEADER="Authorization: token $GITHUB_OATH_TOKEN"
	CURL_USER="${BINTRAY_USER}:${BINTRAY_API_KEY}"

	if [ "$CPU_TARGET" = "ara" ]
	then
		CPU_TARGET="040"
	elif [ "$CPU_TARGET" = "prg" ]
	then
		CPU_TARGET="000"
	fi

	LIBCMINI_URL=$(curl -s -H "$CURL_HEADER" https://api.github.com/repos/freemint/libcmini/releases/latest | jq -r '.assets[].browser_download_url')

	cd ..
	mkdir libcmini
	wget -q -O - "$LIBCMINI_URL" | tar xzf - -C libcmini
	cd -

	cd .travis
	for package in toswin2 qed cops hypview
	do
		unset PACKAGE_VERSION
		unset PACKAGE_PATH
		PACKAGE_VERSION=$(curl -s -u "${CURL_USER}" -X GET "https://api.bintray.com/packages/freemint/freemint/$package" | jq -r '.latest_version')
		read PACKAGE_PATH \
			<<< $(curl -s -u "${CURL_USER}" -X GET "https://api.bintray.com/packages/freemint/freemint/$package/versions/$PACKAGE_VERSION/files" \
				| jq -r '.[] | select(.name | endswith("-" + env.CPU_TARGET + ".zip")) | .path')
		wget -q -O temp.zip "https://dl.bintray.com/freemint/freemint/$PACKAGE_PATH" && unzip -q temp.zip && rm temp.zip
	done
	cd -

	sudo mkdir -p "/usr/m68k-atari-mint"
	cd "/usr/m68k-atari-mint"
	for package in mintlib fdlibm gemlib cflib gemma
	do
		unset PACKAGE_VERSION
		unset PACKAGE_PATH
		PACKAGE_VERSION=$(curl -s -u "${CURL_USER}" -X GET "https://api.bintray.com/packages/freemint/freemint/$package" | jq -r '.latest_version')
		read PACKAGE_PATH \
			<<< $(curl -s -u "${CURL_USER}" -X GET "https://api.bintray.com/packages/freemint/freemint/$package/versions/$PACKAGE_VERSION/files" \
				| jq -r '.[].path')
		wget -q -O - "https://dl.bintray.com/freemint/freemint/$PACKAGE_PATH" | sudo tar xjf -
	done
	cd -

	if [ "$CPU_TARGET" = "000" ]
	then
		DOSFSTOOLS_URL=$(curl -s -H "$CURL_HEADER" https://api.github.com/repos/freemint/dosfstools/releases/latest | jq -r '.assets[].browser_download_url' | grep 'm68000')
	elif [ "$CPU_TARGET" = "col" ]
	then
		DOSFSTOOLS_URL=$(curl -s -H "$CURL_HEADER" https://api.github.com/repos/freemint/dosfstools/releases/latest | jq -r '.assets[].browser_download_url' | grep '5475')
	else
		# 02060, 030, 040, 060
		DOSFSTOOLS_URL=$(curl -s -H "$CURL_HEADER" https://api.github.com/repos/freemint/dosfstools/releases/latest | jq -r '.assets[].browser_download_url' | grep 'm68020-60')
	fi

	cd .travis
	mkdir dosfstools
	wget -q -O - "$DOSFSTOOLS_URL" | tar xjf - -C dosfstools
	cd -
else
	sudo apt-get install mintlib-m68k-atari-mint pml-m68k-atari-mint gemlib-m68k-atari-mint cflib-m68k-atari-mint gemma-m68k-atari-mint
fi

# HCP is defined as "/tmp/hcp/bin/hcp"
HCP_VERSION="1.0.4"
# UDO is defined as "/tmp/udo/bin/udo"
UDO_VERSION="7.12"

cd /tmp
wget -q -O - "http://tho-otto.de/download/hcp-${HCP_VERSION}-linux.tar.bz2" | tar xjf -
mv "hcp-${HCP_VERSION}" hcp

mkdir -p "/tmp/udo/bin"
cd "/tmp/udo/bin"
wget -q -O - "http://www.tho-otto.de/download/udo-${UDO_VERSION}-linux.tar.bz2" | tar xjf -
