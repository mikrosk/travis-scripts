#!/bin/bash -eux
# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -x: Display expanded script commands

SRC="$1"
DST="$2"
VER="$3"
CUR="$4"

PWD="$(dirname "$0")"
. "$PWD/util.sh"

# three separate CPU classes (and archives): 000, 020-60, V4E
AUTODIR_000="$DST/000/auto"
MINTDIR_000="$DST/000/mint/$VER"
XAAESDIR_000="$MINTDIR_000/xaaes"
SYSROOT_000="$MINTDIR_000/sysroot"
USBDIR_000="$MINTDIR_000/usb"
TBLDIR_000="$MINTDIR_000/tbl"
FONTSDIR_000="$MINTDIR_000/fonts"

AUTODIR_020="$DST/020/auto"
MINTDIR_020="$DST/020/mint/$VER"
XAAESDIR_020="$MINTDIR_020/xaaes"
SYSROOT_020="$MINTDIR_020/sysroot"
USBDIR_020="$MINTDIR_020/usb"
TBLDIR_020="$MINTDIR_020/tbl"
FONTSDIR_020="$MINTDIR_020/fonts"

AUTODIR_V4E="$DST/col/auto"
MINTDIR_V4E="$DST/col/mint/$VER"
XAAESDIR_V4E="$MINTDIR_V4E/xaaes"
SYSROOT_V4E="$MINTDIR_V4E/sysroot"
USBDIR_V4E="$MINTDIR_V4E/usb"
TBLDIR_V4E="$MINTDIR_V4E/tbl"
FONTSDIR_V4E="$MINTDIR_V4E/fonts"

# 68000 only (*.prg)
USB4TOSDIR="$DST/usb4tos"

copy_auto "$AUTODIR_000" "000"
copy_auto "$AUTODIR_020" "02060"
copy_auto "$AUTODIR_V4E" "col"

# TODO: mintloader doesn't detect Hatari (but it could via trap #1 handler pointing to the cartridge area)
copy_kernel "$MINTDIR_000" "000" "hat"
copy_kernel "$MINTDIR_020" "030" "040" "060" "mil" "ara"
copy_kernel "$MINTDIR_V4E" "col"

copy_modules "$MINTDIR_000" "000"
copy_modules "$MINTDIR_020" "02060"
copy_modules "$MINTDIR_V4E" "col"

# mchdir: st, ste, megaste, tt, falcon, milan, hades, ct60, firebee, aranym
copy_m68k_modules "$MINTDIR_000"
copy_st_modules "$MINTDIR_000"
# TODO: this one is not detected by FreeMiNT !!!
copy_megast_modules "$MINTDIR_000"
copy_ste_modules "$MINTDIR_000"
copy_megaste_modules "$MINTDIR_000"

copy_m68k_modules "$MINTDIR_020"
copy_tt_modules "$MINTDIR_020"
copy_falcon_modules "$MINTDIR_020"
copy_milan_modules "$MINTDIR_020"
copy_hades_modules "$MINTDIR_020"
copy_ct60_modules "$MINTDIR_020"

copy_firebee_modules "$MINTDIR_V4E"

copy_xaloader "$XAAESDIR_000" "000"
copy_xaloader "$XAAESDIR_020" "02060"
copy_xaloader "$XAAESDIR_V4E" "col"

copy_xaaes "$XAAESDIR_000" "000"
copy_xaaes "$XAAESDIR_020" "02060"
copy_xaaes "$XAAESDIR_V4E" "col"

copy_usbloader "$USBDIR_000" "000"
copy_usbloader "$USBDIR_020" "02060"
copy_usbloader "$USBDIR_V4E" "col"

copy_usb "$USBDIR_000" "000"
copy_usb "$USBDIR_020" "02060"
# unfortunately the usb loader isn't aware of SYSDIR or MCHDIR
cp "$SRC/sys/usb/src.km/ucd/ethernat/ethernat.ucd" "$USBDIR_020"
cp "$SRC/sys/usb/src.km/ucd/aranym/aranym.ucd" "$USBDIR_020"
copy_usb "$USBDIR_V4E" "col"

copy_usb4tos

copy_fonts "$FONTSDIR_000"
copy_fonts "$FONTSDIR_020"
copy_fonts "$FONTSDIR_V4E"

copy_tbl "$TBLDIR_000"
copy_tbl "$TBLDIR_020"
copy_tbl "$TBLDIR_V4E"

copy_sysroot "$SYSROOT_000" "000"
copy_sysroot "$SYSROOT_020" "02060"
copy_sysroot "$SYSROOT_V4E" "col"

# Atari hardware only
mkdir -p "$SYSROOT_020/bin"
cp "$SRC/sys/xdd/audio/actrl" "$SYSROOT_000/bin/actrl.ttp"
cp "$SRC/sys/xdd/audio/actrl" "$SYSROOT_020/bin/actrl.ttp"
