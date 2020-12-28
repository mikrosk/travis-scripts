# use as: . commit.sh

SHORT_ID=$(echo ${GITHUB_SHA} | cut -c 1-3)
LONG_ID=$(echo ${GITHUB_SHA} | cut -c 1-8)
