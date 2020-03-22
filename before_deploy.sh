#!/bin/bash -eux
# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -x: Display expanded script commands

HERE=$(dirname "$0")
. "$HERE/commit.sh"

if [ -z "${DEPLOY_ARCHIVE+x}" ]
then
	# zip is default
	DEPLOY_ARCHIVE="zip"
fi

if [ -n "${CPU_TARGET+x}" ]
then
	ARCHIVE_PATH="${DEPLOY_DIR}/${PROJECT_NAME}-${PROJECT_VERSION}-${SHORT_ID}-${CPU_TARGET}.${DEPLOY_ARCHIVE}"
else
	ARCHIVE_PATH="${DEPLOY_DIR}/${PROJECT_NAME}-${PROJECT_VERSION}-${SHORT_ID}.${DEPLOY_ARCHIVE}"
fi

mkdir -p "${DEPLOY_DIR}"

if [ "${DEPLOY_ARCHIVE}" = "tar.bz2" ]
then
	cd ${INSTALL_DIR} && tar cjf ${ARCHIVE_PATH} *
elif [ "${DEPLOY_ARCHIVE}" = "tar.gz" ]
then
	cd ${INSTALL_DIR} && tar czf ${ARCHIVE_PATH} *
else
	cd $(dirname ${INSTALL_DIR}) && zip -r -9 ${ARCHIVE_PATH} $(basename ${INSTALL_DIR})
fi

cd -

sed -i -e "s/PACKAGE_NAME/${PROJECT_NAME}/g;" .travis/bintray.desc
sed -i -e "s/PACKAGE_VERSION/${PROJECT_VERSION}-${LONG_ID}/g;" .travis/bintray.desc
sed -i -e "s/COMMIT_ID/${LONG_ID}/g;" .travis/bintray.desc
sed -i -e "s/COMMIT_URL/https:\/\/github.com\/${PROJECT_REPO}\/${PROJECT_NAME}\/commit\/${LONG_ID}/g;" .travis/bintray.desc
# ${DEPLOY_DIR} must not contain '#'
sed -i -e "s#DEPLOY_DIR#${DEPLOY_DIR}#g;" .travis/bintray.desc
