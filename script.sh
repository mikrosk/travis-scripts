#!/bin/bash -ex
# -e: Exit immediately if a command exits with a non-zero status.
# -x: Display expanded script commands

export M68K_ATARI_MINT_CROSS=yes
export LIBCMINI=yes

SHORT_ID=$(git log -n1 --format="%H" | cut -c 1-3)
PROJECT=$(echo "${TRAVIS_REPO_SLUG}" | cut -d '/' -f 2)

HERE="$(dirname "$0")"
. "$HERE/version.sh"

ARANYM="${PWD}/.travis/aranym"
export TERADESK_DIR="${PWD}/.travis/teradesk"
export BASH_DIR="${PWD}/.travis/bash"
export COREUTILS_DIR="${PWD}/.travis/coreutils"
export QED_DIR="${PWD}/.travis/qed"
export DOSFSTOOLS_DIR="${PWD}/.travis/dosfstools"
export COPS_DIR="${PWD}/.travis/cops"
export HYPVIEW_DIR="${PWD}/.travis/hypview"
export TOSWIN2_DIR="${PWD}/.travis/toswin2"
TMP="${PWD}/.travis/.tmp"
OUT="${PWD}/.travis"

mkdir -p "${OUT}"

if [ "$CPU_TARGET" = "ara" ]
then
	make
	DST="${TMP}/aranym-${SHORT_VERSION}"
	"./.travis/prepare-aranym.sh" "${PWD}" "${DST}" "${SHORT_VERSION}" "${ARANYM}"
	find "${DST}" -type f -perm -a=x -exec m68k-atari-mint-strip -s {} \;
	cd "${DST}/.." && zip -r -9 "${OUT}/${PROJECT}-${SHORT_VERSION}-040${VERSIONED}.zip" "$(basename ${DST})" && cd -
elif [ "$CPU_TARGET" = "prg" ]
then
	cd sys/usb && make && cd -
	cd tools/usbtool && make all && cd -
	DST="${TMP}/usb4tos-${SHORT_VERSION}"
	"./.travis/prepare-usb4tos.sh" "${PWD}" "${DST}"
	find "${DST}" -type f -perm -a=x -exec m68k-atari-mint-strip -s {} \;
	cd "${DST}/.." && zip -r -9 "${OUT}/usb4tos-${SHORT_VERSION}.zip" "$(basename ${DST})" && cd -
else
	make
	DST="${TMP}/mint-${SHORT_VERSION}-${CPU_TARGET}"
	"./.travis/prepare-snapshot.sh" "${PWD}" "${DST}" "${SHORT_VERSION}" "${SHORT_ID}"
	find "${DST}" -type f -perm -a=x -exec m68k-atari-mint-strip -s {} \;
	cd "${DST}" && zip -r -9 "${OUT}/${PROJECT}-${SHORT_VERSION}-${CPU_TARGET}${VERSIONED}.zip" * && cd -
fi
