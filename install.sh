#!/bin/bash -eux
# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -x: Display expanded script commands

LIBCMINI_URL="https://github.com/mfro0/libcmini/releases/download"
LIBCMINI_VERSION="0.49"

cd ..
wget -qO- "$LIBCMINI_URL/v$LIBCMINI_VERSION/libcmini-$LIBCMINI_VERSION.tar.gz" | tar xzf -
cd -
