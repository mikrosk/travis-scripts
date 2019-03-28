#!/bin/bash -eux
# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -x: Display expanded script commands

export TODAY=`date +%d%m%Y`

OUT="${PWD}/.travis"

./.travis/freemint.build "${OUT}"
ls -l "${OUT}"

# do it here as we want to have VERSION in sync with filename
sed -i -e "s/MINT_MAJ_VERSION-MINT_MIN_VERSION-MINT_PATCH_LEVEL/helmut-${TODAY}/g;" .travis/bintray.desc
