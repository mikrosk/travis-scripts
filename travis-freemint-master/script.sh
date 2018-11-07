#!/bin/bash -eux
# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -x: Display expanded script commands

export M68K_ATARI_MINT_CROSS=yes

SHORT_ID=$(git log -n1 --format="%H" | cut -c 1-3)
PROJECT=$(echo "${TRAVIS_REPO_SLUG}" | cut -d '/' -f 2)
VERSION=$(/tmp/version)
ARANYM="${PWD}/.travis/aranym"
TMP="${PWD}/.travis/.tmp"
OUT="${PWD}/.travis"

make

mkdir -p "${TMP}"
"./.travis/prepare-snapshot.sh" "${PWD}" "${TMP}/mint-${SHORT_ID}"  "${VERSION}" "${SHORT_ID}"
"./.travis/prepare-aranym.sh"   "${PWD}" "${TMP}/aranym-${VERSION}" "${VERSION}" "${SHORT_ID}" "${ARANYM}"

find "${TMP}" -type f -perm -a=x -exec m68k-atari-mint-strip -s {} \;

ls -l "${TMP}"

mkdir -p "${OUT}"
cd "${TMP}/mint-${SHORT_ID}/000" && zip -r -9 "${OUT}/${PROJECT}-${VERSION}-000.zip" * > /dev/null && cd -
cd "${TMP}/mint-${SHORT_ID}/020" && zip -r -9 "${OUT}/${PROJECT}-${VERSION}-020.zip" * > /dev/null && cd -
cd "${TMP}/mint-${SHORT_ID}/col" && zip -r -9 "${OUT}/${PROJECT}-${VERSION}-col.zip" * > /dev/null && cd -
cd "${TMP}/mint-${SHORT_ID}" && zip -r -9 "${OUT}/${PROJECT}-${VERSION}-usb4tos.zip" "usb4tos" > /dev/null && cd -

cd "${TMP}" && zip -r -9 "${OUT}/aranym-${VERSION}.zip" "aranym-${VERSION}" > /dev/null && cd -

ls -l "${OUT}"
