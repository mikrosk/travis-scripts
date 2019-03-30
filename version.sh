# use as: . version.sh

HERE="$(dirname "$0")"
. "$HERE/commit.sh"

SHORT_VERSION=$(/tmp/version)

MINT_MAJ_VERSION=$(echo ${SHORT_VERSION} | cut -d - -f 1)
MINT_MIN_VERSION=$(echo ${SHORT_VERSION} | cut -d - -f 2)
MINT_PATCH_LEVEL=$(echo ${SHORT_VERSION} | cut -d - -f 3)
if [ ${#MINT_PATCH_LEVEL} -eq 3 ]
then
	MINT_PATCH_LEVEL=${LONG_ID}
fi

LONG_VERSION=${MINT_MAJ_VERSION}-${MINT_MIN_VERSION}-${MINT_PATCH_LEVEL}
