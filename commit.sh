# use as: . commit.sh

SHORT_ID=$(echo ${TRAVIS_COMMIT} | cut -c 1-3)
LONG_ID=$(echo ${TRAVIS_COMMIT} | cut -c 1-8)
