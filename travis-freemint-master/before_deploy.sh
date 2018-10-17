#!/bin/bash -eux
# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -x: Display expanded script commands

VERSION=$(/tmp/version)
MINT_MAJ_VERSION=$(echo ${VERSION} | cut -d - -f 1)
MINT_MIN_VERSION=$(echo ${VERSION} | cut -d - -f 2)
MINT_PATCH_LEVEL=$(echo ${VERSION} | cut -d - -f 3)

TRAVIS_COMMIT=$(echo ${TRAVIS_COMMIT} | cut -c 1-8)

if [ ${#MINT_PATCH_LEVEL} -eq 3 ]
then
	MINT_PATCH_LEVEL=${TRAVIS_COMMIT}
fi

sed -i -e "s/MINT_MAJ_VERSION-MINT_MIN_VERSION-MINT_PATCH_LEVEL/${MINT_MAJ_VERSION}-${MINT_MIN_VERSION}-${MINT_PATCH_LEVEL}/g;" .travis/bintray.desc
sed -i -e "s/COMMIT_ID/${TRAVIS_COMMIT}/g;" .travis/bintray.desc
USER=$(echo "${TRAVIS_REPO_SLUG}" | cut -d '/' -f 1)
PROJECT=$(echo "${TRAVIS_REPO_SLUG}" | cut -d '/' -f 2)
sed -i -e "s/COMMIT_URL/https:\/\/github.com\/${USER}\/${PROJECT}\/commit\/${TRAVIS_COMMIT}/g;" .travis/bintray.desc
