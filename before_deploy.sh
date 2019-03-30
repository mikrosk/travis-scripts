#!/bin/bash -eux
# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -x: Display expanded script commands

HERE="$(dirname "$0")"
. "$HERE/version.sh"
. "$HERE/commit.sh"

if [ -n "${VERSIONED+x}" ]
then
	sed -i -e "s/PACKAGE_NAME/snapshots/g;" .travis/bintray.desc
else
	if [ "$CPU_TARGET" = "prg" ]
	then
		sed -i -e "s/PACKAGE_NAME/snapshots-usb4tos/g;" .travis/bintray.desc
	else
		sed -i -e "s/PACKAGE_NAME/snapshots-cpu/g;" .travis/bintray.desc
	fi
fi

sed -i -e "s/MINT_MAJ_VERSION-MINT_MIN_VERSION-MINT_PATCH_LEVEL/${LONG_VERSION}/g;" .travis/bintray.desc
sed -i -e "s/COMMIT_ID/${LONG_ID}/g;" .travis/bintray.desc
USER=$(echo "${TRAVIS_REPO_SLUG}" | cut -d '/' -f 1)
PROJECT=$(echo "${TRAVIS_REPO_SLUG}" | cut -d '/' -f 2)
sed -i -e "s/COMMIT_URL/https:\/\/github.com\/${USER}\/${PROJECT}\/commit\/${LONG_ID}/g;" .travis/bintray.desc
