EmuTOS - ARAnyM version

This ROM is optimized for ARAnyM:
https://aranym.github.io/

emutos-aranym.img - Multilanguage

The following optional files are also supplied:
emucurs.rsc - modifiable mouse cursors for the AES/desktop
emucurs.def - definition file for the above
emuicon.rsc - contains additional icons for the desktop
emuicon.def - definition file for the above

Note that the emuicon.rsc file format differs from deskicon.rsc used by later
versions of the Atari TOS desktop.

The default language is English.
Other languages can be used by setting the NVRAM appropriately.

Alternatively, you can add the -k xx option on the ARAnyM command line
to force a specific language, where xx is:
cz - Czech
de - German
es - Spanish
fi - Finnish
fr - French
gr - Greek
it - Italian
no - Norwegian
ru - Russian (currently unsupported by ARAnyM)
se - Swedish
cd - Swiss German
us - English (US)
uk - English (UK)

Note that selecting Norwegian/Swedish currently sets the language to English,
but the keyboard layout to Norwegian/Swedish.

The ARAnyM ROM features:
- optimization for 68040 CPU
- builtin MMU support for FreeMiNT (see below)
- no ACSI support
- full NatFeat support (also enabled in the standard 512 KB version)

Builtin MMU support for FreeMiNT
As of release 0.9.11, the ARAnyM ROM always initialises the PMMU to
support enabling memory protection under FreeMiNT. If you have been using
set_mmu.prg to have FreeMiNT running with memory protection enabled, you
can safely disable it. It will do no harm to continue to use set_mmu.prg,
but it is no longer required. Because the ARAnyM ROM now always builds
PMMU tables, memory usage will increase somewhat (compared to earlier
releases) if you continue to use set_mmu.prg, or if you do not use memory
protection under FreeMiNT, or if you do not use FreeMiNT at all.

This ROM image has been built using:
make aranym

This release has been built on Linux Mint (a Ubuntu derivative), using
Vincent Rivière's GCC 4.6.4 cross-compiler.  The custom tools used in
the build process were built with native GCC 4.8.4.

The source package and other binary packages are available at:
https://sourceforge.net/projects/emutos/files/emutos/0.9.11/

The extras directory (if provided) contains one or more alternate desktop
icon sets, which you can use to replace the builtin ones.  You can use a
standard resource editor to see what the replacement icons look like.
To use a replacement set, move or rename the existing emuicon.rsc &
emuicon.def files in the root directory, then copy the files containing
the desired icons to the root, and rename them to emuicon.rsc/emuicon.def.
For further information, see doc/emudesk.txt.

If you want to read more about EmuTOS, please take a look at these files:

doc/announce.txt      - Introduction and general description, including
                        a summary of changes since the previous version
doc/authors.txt       - A list of the authors of EmuTOS
doc/bugs.txt          - Currently known bugs
doc/changelog.txt     - A summarised list of changes after release 0.9.4
doc/emudesk.txt       - A brief guide to the newer features of the desktop
doc/incompatible.txt  - Programs incompatible with EmuTOS due to program bugs
doc/license.txt       - The FSF General Public License for EmuTOS
doc/license_aros.txt  - The AROS Public License for certain Amiga source
                        code distributed as part of EmuTOS source
doc/status.txt        - What is implemented and running (or not yet)
doc/todo.txt          - What should be done in future versions
doc/xhdi.txt          - Current XHDI implementation status

Additional information for developers (just in the source archive):

doc/install.txt       - How to build EmuTOS from sources
doc/coding.txt        - EmuTOS coding standards (never used :-) )
doc/country.txt       - An overview of i18n issues in EmuTOS
doc/fat16.txt         - Notes on the FAT16 filesystem in EmuTOS
doc/memdetect.txt     - Memory bank detection during EmuTOS startup
doc/nls.txt           - How to add a native language or use one
doc/old_changelog.txt - A summarised list of changes up to & including
                        release 0.9.4
doc/osmemory.txt      - All about OS internal memory in EmuTOS
doc/reschange.txt     - How resolution change works in the desktop
doc/resource.txt      - Modifying resources in EmuTOS
doc/
doc/tos14fix.txt      - Lists bugs fixed by TOS 1.04 & their status in EmuTOS

The following documents are principally of historical interest only:

doc/old_code.txt      - A museum of bugs due to old C language
doc/vdibind.txt       - Old information on VDI bindings

-- 
The EmuTOS development team
http://emutos.sourceforge.net/
