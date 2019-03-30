#!/bin/bash -eux
# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -x: Display expanded script commands

SRC="$1"
DST="$2"

HERE="$(dirname "$0")"
. "$HERE/util.sh"

copy_usb4tos "$DST"
