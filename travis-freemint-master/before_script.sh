#!/bin/bash -eux
# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -x: Display expanded script commands

SHORT_ID=$(git log -n1 --format="%H" | cut -c 1-3)
sed -i -e "s/\"cur\"/\"${SHORT_ID}\"/;" sys/buildinfo/version.h
gcc -I"sys" -o /tmp/version .travis/version.c

# limit building to selected CPU targets
sed -i -e "s/xaaestargets = deb 000 sto 030 040 060 col 02060/xaaestargets = 000 02060 col/;" ./xaaes/src.km/XAAESDEFS
sed -i -e "s/moosetargets = 02060 030 040 060 deb 000 col/moosetargets = 000 02060 col/;" ./xaaes/src.km/adi/whlmoose/MOOSEDEFS
sed -i -e "s/kerneltargets = 000 020 030 040 060 deb mil ara hat/kerneltargets = 000 030 040 060 mil ara hat/;" ./sys/KERNELDEFS
sed -i -e "s/ext2targets = 02060 030 040 060 deb 000 col/ext2targets = 000 02060 col/;" ./sys/xfs/ext2fs/EXT2DEFS
sed -i -e "s/nfstargets = 02060 030 040 060 deb 000 col/nfstargets = 000 02060 col/;" ./sys/xfs/nfs/NFSDEFS
sed -i -e "s/minixtargets = 02060 030 040 060 deb 000 col/minixtargets = 000 02060 col/;" ./sys/xfs/minixfs/MINIXDEFS
sed -i -e "s/xconout2targets = 02060 030 040 060 deb 000 col/xconout2targets = 000 02060 col/;" ./sys/xdd/xconout2/XCONOUT2DEFS
sed -i -e "s/lptargets = 02060 030 040 060 deb 000 col/lptargets = 000 02060 col/;" ./sys/xdd/lp/LPDEFS
sed -i -e "s/ethtargets = 02060 030 040 060 deb 000 col prg/ethtargets = 000 02060 col prg/;" ./sys/usb/src.km/udd/eth/ETHDEFS
sed -i -e "s/mousetargets = 02060 030 040 060 deb 000 col prg/mousetargets = 000 02060 col prg/;" ./sys/usb/src.km/udd/mouse/MOUSEDEFS
sed -i -e "s/storagetargets = 02060 030 040 060 deb 000 col prg/storagetargets = 000 02060 col prg/;" ./sys/usb/src.km/udd/storage/STORAGEDEFS
sed -i -e "s/usbtargets = 02060 030 040 060 deb 000 col prg/usbtargets = 000 02060 col prg/;" ./sys/usb/src.km/USBDEFS
sed -i -e "s/ehcitargets = 02060 030 040 060 deb 000 col #prg/ehcitargets = 000 02060 col/;" ./sys/usb/src.km/ucd/ehci/EHCIDEFS
sed -i -e "s/unicorntargets = 02060 030 040 060 deb 000 col prg/unicorntargets = 000 02060 col prg/;" ./sys/usb/src.km/ucd/unicorn/UNICORNDEFS
sed -i -e "s/inet4targets = 02060 030 040 060 deb 000 col/inet4targets = 000 02060 col/;" ./sys/sockets/INET4DEFS
sed -i -e "s/inet4targets = 02060 030 040 060 deb 000 col/inet4targets = 000 02060 col/;" ./sys/sockets/inet4/INET4DEFS
