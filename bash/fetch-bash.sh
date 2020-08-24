#!/bin/sh

set -e

baseurl=http://tho-otto.de/download/mint/bash-4.4-mint-

for CPU in 000 020 v4e; do
	file=${baseurl}${CPU}.tar.xz
	wget $file
	tar xf ${file##*/}
	for tool in sh bash; do
		cp -a bin/$tool ${tool}${CPU}.ttp
	done
	rm -rf bin usr etc ${file##*/}
done
