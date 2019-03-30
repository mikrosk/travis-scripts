# use as: . commit.sh

SHORT_ID=$(git log -n1 --format="%H" | cut -c 1-3)
LONG_ID=$(git log -n1 --format="%H" | cut -c 1-8)
