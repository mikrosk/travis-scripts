#!/bin/bash -eux
# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -x: Display expanded script commands

SHORT_ID=$(git log -n1 --format="%H" | cut -c 1-3)
sed -i -e "s/\"cur\"/\"${SHORT_ID}\"/;" sys/buildinfo/version.h
gcc -I"sys" -o /tmp/version .travis/version.c

# limit building to selected CPU targets
sed -i -e "s/xaloadtargets = 000 02060 030 040 060 col/xaloadtargets = 000 02060 col/;" ./xaaes/src.km/xaloader/XALOADDEFS
sed -i -e "s/xaaestargets = deb 000 sto 030 040 060 col 02060/xaaestargets = 000 02060 col/;" ./xaaes/src.km/XAAESDEFS
sed -i -e "s/moosetargets = 02060 030 040 060 deb 000 col/moosetargets = 000 02060 col/;" ./xaaes/src.km/adi/whlmoose/MOOSEDEFS
sed -i -e "s/kerneltargets = 000 020 030 040 060 deb mil ara hat/kerneltargets = 000 030 040 060 mil ara hat/;" ./sys/KERNELDEFS
sed -i -e "s/ext2targets = 02060 030 040 060 deb 000 col/ext2targets = 000 02060 col/;" ./sys/xfs/ext2fs/EXT2DEFS
sed -i -e "s/nfstargets = 02060 030 040 060 deb 000 col/nfstargets = 000 02060 col/;" ./sys/xfs/nfs/NFSDEFS
sed -i -e "s/minixtargets = 02060 030 040 060 deb 000 col/minixtargets = 000 02060 col/;" ./sys/xfs/minixfs/MINIXDEFS
sed -i -e "s/xconout2targets = 02060 030 040 060 deb 000 col/xconout2targets = 000 02060 col/;" ./sys/xdd/xconout2/XCONOUT2DEFS
sed -i -e "s/lptargets = 02060 030 040 060 deb 000 col/lptargets = 000 02060 col/;" ./sys/xdd/lp/LPDEFS
sed -i -e "s/usbloadtargets = 000 02060 030 040 060 col/usbloadtargets = 000 02060 col/;" ./sys/usb/src.km/loader/USBLOADDEFS
sed -i -e "s/ethtargets = 02060 030 040 060 deb 000 col prg/ethtargets = 000 02060 col prg/;" ./sys/usb/src.km/udd/eth/ETHDEFS
sed -i -e "s/mousetargets = 02060 030 040 060 deb 000 col prg/mousetargets = 000 02060 col prg/;" ./sys/usb/src.km/udd/mouse/MOUSEDEFS
sed -i -e "s/storagetargets = 02060 030 040 060 deb 000 col prg/storagetargets = 000 02060 col prg/;" ./sys/usb/src.km/udd/storage/STORAGEDEFS
sed -i -e "s/usbtargets = 02060 030 040 060 deb 000 col prg/usbtargets = 000 02060 col prg/;" ./sys/usb/src.km/USBDEFS
sed -i -e "s/ehcitargets = 02060 030 040 060 deb 000 col #prg/ehcitargets = 000 02060 col/;" ./sys/usb/src.km/ucd/ehci/EHCIDEFS
sed -i -e "s/unicorntargets = 02060 030 040 060 deb 000 col prg/unicorntargets = 000 02060 col prg/;" ./sys/usb/src.km/ucd/unicorn/UNICORNDEFS
sed -i -e "s/inet4targets = 02060 030 040 060 deb 000 col/inet4targets = 000 02060 col/;" ./sys/sockets/INET4DEFS
sed -i -e "s/inet4targets = 02060 030 040 060 deb 000 col/inet4targets = 000 02060 col/;" ./sys/sockets/inet4/INET4DEFS
sed -i -e "s/copstargets = english_000 france_000 german_000 english_02060 france_02060 german_02060 english_030 france_030 german_030 english_040 france_040 german_040 english_060 france_060  german_060 english_col france_col german_col/copstargets = english_000 france_000 german_000 english_02060 france_02060 german_02060 english_col france_col german_col/;" ./tools/cops/COPSDEFS
sed -i -e "s/cryptotargets = 000 02060 030 040 060 col/cryptotargets = 000 02060 col/;" ./tools/crypto/CRYPTODEFS
sed -i -e "s/fdisktargets = 000 02060 030 040 060 col/fdisktargets = 000 02060 col/;" ./tools/fdisk/FDISKDEFS
sed -i -e "s/fsettertargets = 000 02060 030 040 060 col/fsettertargets = 000 02060 col/;" ./tools/fsetter/FSETTERDEFS
sed -i -e "s/gluestiktargets = 000 02060 030 040 060 col/gluestiktargets = 000 02060 col/;" ./tools/gluestik/GLUESTIKDEFS
sed -i -e "s/hypviewtargets = 000 02060 030 040 060 col/hypviewtargets = 000 02060 col/;" ./tools/hypview/HYPVIEWDEFS
sed -i -e "s/bubbletargets = 000 02060 030 040 060 col/bubbletargets = 000 02060 col/;" ./tools/hypview/bubble/BUBBLEDEFS
sed -i -e "s/dragdroptargets = 000 02060 030 040 060 col/dragdroptargets = 000 02060 col/;" ./tools/hypview/dragdrop/DRAGDROPDEFS
sed -i -e "s/hyptargets = 000 02060 030 040 060 col/hyptargets = 000 02060 col/;" ./tools/hypview/hyp/HYPDEFS
sed -i -e "s/plaintargets = 000 02060 030 040 060 col/plaintargets = 000 02060 col/;" ./tools/hypview/plain/PLAINDEFS
sed -i -e "s/iotargets = 000 02060 030 040 060 col/iotargets = 000 02060 col/;" ./tools/IO/IODEFS
sed -i -e "s/lpflushtargets = 000 02060 030 040 060 col/lpflushtargets = 000 02060 col/;" ./tools/lpflush/LPFLUSHDEFS
sed -i -e "s/mgwtargets = 000 02060 030 040 060 col/mgwtargets = 000 02060 col/;" ./tools/mgw/MGWDEFS
sed -i -e "s/fscktargets = 000 02060 030 040 060 col/fscktargets = 000 02060 col/;" ./tools/minix/fsck/FSCKDEFS
sed -i -e "s/minittargets = 000 02060 030 040 060 col/minittargets = 000 02060 col/;" ./tools/minix/minit/MINITDEFS
sed -i -e "s/toolstargets = 000 02060 030 040 060 col/toolstargets = 000 02060 col/;" ./tools/minix/tools/TOOLSDEFS
sed -i -e "s/mintloadtargets = 000 02060 030 040 060 col/mintloadtargets = 000 02060 col/;" ./tools/mintload/MINTLOADDEFS
sed -i -e "s/mkfatfstargets = 000 02060 030 040 060 col/mkfatfstargets = 000 02060 col/;" ./tools/mkfatfs/MKFATFSDEFS
sed -i -e "s/mktbltargets = 000 02060 030 040 060 col/mktbltargets = 000 02060 col/;" ./tools/mktbl/MKTBLDEFS
sed -i -e "s/nettoolstargets = 000 02060 030 040 060 col/nettoolstargets = 000 02060 col/;" ./tools/net-tools/NETTOOLSDEFS
sed -i -e "s/slinkctltargets = 000 02060 030 040 060 col/slinkctltargets = 000 02060 col/;" ./tools/net-tools/slinkctl/SLINKCTLDEFS
sed -i -e "s/teststargets = 000 02060 030 040 060 col/teststargets = 000 02060 col/;" ./tools/net-tools/tests/TESTSDEFS
sed -i -e "s/nfstargets = 000 02060 030 040 060 col/nfstargets = 000 02060 col/;" ./tools/nfs/NFSDEFS
sed -i -e "s/nohog2targets = 000 02060 030 040 060 col/nohog2targets = 000 02060 col/;" ./tools/nohog2/NOHOG2DEFS
sed -i -e "s/stracetargets = 000 02060 030 040 060 col/stracetargets = 000 02060 col/;" ./tools/strace/STRACEDEFS
sed -i -e "s/swkbdtbltargets = 000 02060 030 040 060 col/swkbdtbltargets = 000 02060 col/;" ./tools/swkbdtbl/SWKBDTBLDEFS
sed -i -e "s/sysctltargets = 000 02060 030 040 060 col/sysctltargets = 000 02060 col/;" ./tools/sysctl/SYSCTLDEFS
sed -i -e "s/toswin2targets = 000 02060 030 040 060 col/toswin2targets = 000 02060 col/;" ./tools/toswin2/TOSWIN2DEFS
sed -i -e "s/twcalltargets = 000 02060 030 040 060 col/twcalltargets = 000 02060 col/;" ./tools/toswin2/tw-call/TWCALLDEFS
sed -i -e "s/usbtooltargets = 000 02060 030 040 060 col/usbtooltargets = 000 02060 col/;" ./tools/usbtool/USBTOOLDEFS
