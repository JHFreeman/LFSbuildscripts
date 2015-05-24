#!/bin/bash -e

export LFS=/mnt/lfs

source ../as_root.sh

if [ ! -d ${LFS}/dev ]; then
	as_root mkdir -pv ${LFS}/dev
fi
if [ ! -d ${LFS}/proc ]; then
	as_root mkdir -pv ${LFS}/proc
fi
if [ ! -d ${LFS}/sys ]; then
	as_root mkdir -pv ${LFS}/sys
fi
if [ ! -d ${LFS}/run ]; then
	as_root mkdir -pv ${LFS}/run
fi
#as_root mkdir -pv $LFS/{dev,proc,sys,run}

if [ ! -p $LFS/dev/console ]; then
	as_root mknod -m 600 $LFS/dev/console c 5 1
fi
as_root mknod -m 666 $LFS/dev/null c 1 3

as_root mount -v --bind /dev $LFS/dev

as_root mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620
as_root mount -vt proc proc $LFS/proc
as_root mount -vt sysfs sysfs $LFS/sys
as_root mount -vt tmpfs tmpfs $LFS/run

if [ -h $LFS/dev/shm ]; then
	as_root mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi

echo "./1-preparing.sh ran"
