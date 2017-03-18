#!/bin/bash -eux
# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -x: Display expanded script commands

TRAVIS_COMMIT=$(echo ${TRAVIS_COMMIT} | cut -c 1-8)
sed -i -e "s/COMMIT_ID/${TRAVIS_COMMIT}/g;" .travis/bintray.desc
USER=$(echo "${TRAVIS_REPO_SLUG}" | cut -d '/' -f 1)
PROJECT=$(echo "${TRAVIS_REPO_SLUG}" | cut -d '/' -f 2)
sed -i -e "s/COMMIT_URL/https:\/\/github.com\/${USER}\/${PROJECT}\/commit\/${TRAVIS_COMMIT}/g;" .travis/bintray.desc
