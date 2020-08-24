#!/bin/sh

set -e

baseurl=http://tho-otto.de/download/mint/coreutils-8.28-mint-

for CPU in 000 020 v4e; do
	file=${baseurl}${CPU}.tar.xz
	wget $file
	tar xf ${file##*/}
	for tool in cat cp env ln ls md5sum mkdir mv rm; do
		cp -a usr/bin/$tool ${tool}${CPU}.ttp
	done
	rm -rf bin usr etc ${file##*/}
done
