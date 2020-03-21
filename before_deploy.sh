#!/bin/bash -eux
# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -x: Display expanded script commands

HERE=$(dirname "$0")
. "$HERE/commit.sh"

ARCHIVE_FOLDER=$(basename ${INSTALL_DIR})
INSTALL_ROOT=$(dirname ${INSTALL_DIR})

mkdir -p "${DEPLOY_DIR}"

cd "${INSTALL_ROOT}"
zip -r -9 "${DEPLOY_DIR}/${PROJECT_NAME}-${PROJECT_VERSION}-${SHORT_ID}-${CPU_TARGET}.zip" "${ARCHIVE_FOLDER}"
cd -

sed -i -e "s/PACKAGE_NAME/${PROJECT_NAME}/g;" .travis/bintray.desc
sed -i -e "s/PACKAGE_VERSION/${PROJECT_VERSION}-${LONG_ID}/g;" .travis/bintray.desc
sed -i -e "s/COMMIT_ID/${LONG_ID}/g;" .travis/bintray.desc
sed -i -e "s/COMMIT_URL/https:\/\/github.com\/${PROJECT_REPO}\/${PROJECT_NAME}\/commit\/${LONG_ID}/g;" .travis/bintray.desc
# ${DEPLOY_DIR} must not contain '#'
sed -i -e "s#DEPLOY_DIR#${DEPLOY_DIR}#g;" .travis/bintray.desc
