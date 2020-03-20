#!/bin/bash -eux
# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -x: Display expanded script commands

if [ "${TRAVIS_PULL_REQUEST}" = "false" ]
then
CURL_HEADER="Authorization: token $GITHUB_OATH_TOKEN"
else
# use an empty authorization header. this will fall back to 50 requests per hour from given Travis IP (for any project, not only ours!)
CURL_HEADER=""
fi

LIBCMINI_URL=$(curl -s -H "$CURL_HEADER" https://api.github.com/repos/freemint/libcmini/releases/latest | jq -r '.assets[].browser_download_url')
LIBCMINI_NAME=$(curl -s -H "$CURL_HEADER" https://api.github.com/repos/freemint/libcmini/releases/latest | jq -r '.assets[].name')

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

if [ "$CPU_TARGET" = "000" ]
then
	DOSFSTOOLS_URL=$(curl -s -H "$CURL_HEADER" https://api.github.com/repos/freemint/dosfstools/releases/latest | jq -r '.assets[].browser_download_url' | grep 'm68000')
	DOSFSTOOLS_NAME=$(curl -s -H "$CURL_HEADER" https://api.github.com/repos/freemint/dosfstools/releases/latest | jq -r '.assets[].name' | grep 'm68000')
elif [ "$CPU_TARGET" = "col" ]
then
	DOSFSTOOLS_URL=$(curl -s -H "$CURL_HEADER" https://api.github.com/repos/freemint/dosfstools/releases/latest | jq -r '.assets[].browser_download_url' | grep '5475')
	DOSFSTOOLS_NAME=$(curl -s -H "$CURL_HEADER" https://api.github.com/repos/freemint/dosfstools/releases/latest | jq -r '.assets[].name' | grep '5475')
else
	# 02060, 030, 040, 060
	DOSFSTOOLS_URL=$(curl -s -H "$CURL_HEADER" https://api.github.com/repos/freemint/dosfstools/releases/latest | jq -r '.assets[].browser_download_url' | grep 'm68020-60')
	DOSFSTOOLS_NAME=$(curl -s -H "$CURL_HEADER" https://api.github.com/repos/freemint/dosfstools/releases/latest | jq -r '.assets[].name' | grep 'm68020-60')
fi

cd .travis
mkdir dosfstools
wget -q "$DOSFSTOOLS_URL"
tar xjvf "$DOSFSTOOLS_NAME" -C dosfstools
rm "$DOSFSTOOLS_NAME"
cd -

mkdir -p ~/"tmp/udo"
cd ~/"tmp/udo"
wget -q "http://www.tho-otto.de/download/udo-7.12-linux.tar.bz2"
tar xjf udo-7.12-linux.tar.bz2
UDO=~/"tmp/udo/udo"
export UDO
cd -

cd ~/"tmp"
wget -q "http://tho-otto.de/download/hcp-1.0.3-linux.tar.bz2"
tar xjf hcp-1.0.3-linux.tar.bz2
HCP=~/"tmp/hcp-1.0.3/bin/hcp"
export HCP
cd -
