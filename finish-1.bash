#!/bin/bash -e
source as_root.bash

LFS=/mnt/lfs

if [ ! -d $LFS/Home ]; then
	as_root mkdir -v $LFS/Home
fi

if ! grep -qs "$LFS/Home" /proc/mounts; then
	as_root mount -t prl_fs Home $LFS/Home
	if [ $? -eq 0 ]; then
		echo "Successfully mounted $LFS/Home"
	else
		echo "Didn't mount $LFS/Home for some reason"
	fi
fi

as_root apt-get -y install build-essential

as_root apt-get -y install texinfo

if [ ! -e /usr/bin/bison ]; then
	as_root apt-get -y install bison
fi

if [ -e /usr/bin/yacc ]; then
	as_root rm /usr/bin/yacc
fi

as_root ln -sv bison /usr/bin/yacc

if [ ! -e /bin/bash ]; then
	as_root apt-get -y install bash
fi

if [ -h /bin/sh ]; then
	as_root rm /bin/sh
fi

as_root ln -sv bin /bin/sh
