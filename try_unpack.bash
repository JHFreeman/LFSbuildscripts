#!/bin/bash -e

try_unpack()
{
	if [ -f $1.tar.xz ]; then
		tar -xf $1.tar.xz
	elif [ -f $1.tar.gz ]; then
		tar -xf $1.tar.gz
	elif [ -f $1.tgz ]; then
		tar -xf $1.tgz
	elif [ -f $1.tar.bz2 ]; then
		tar -xf $1.tar.bz2
	else
		echo $1.unknown
		return 1
	fi
}

export -f try_unpack


