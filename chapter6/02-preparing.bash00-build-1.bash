#!/bin/bash -e

export LFS=/mnt/lfs

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

if [ ! -d ${LFS}/Home ]; then
	as_root mkdir -pv ${LFS}/Home
fi

if [ ! -e $LFS/dev/console ]; then
	as_root mknod -m 600 $LFS/dev/console c 5 1
fi
if [ ! -e $LFS/dev/null ]; then
	as_root mknod -m 666 $LFS/dev/null c 1 3
fi
if ! grep -qs "$LFS/dev" /proc/mounts; then
	as_root mount -v --bind /dev $LFS/dev
fi

if ! grep -qs "$LFS/dev/pts" /proc/mounts; then
	as_root mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620
fi
if ! grep -qs "$LFS/proc" /proc/mounts; then
	as_root mount -vt proc proc $LFS/proc
fi
if ! grep -qs "$LFS/sys" /proc/mounts; then
	as_root mount -vt sysfs sysfs $LFS/sys
fi
if ! grep -qs "$LFS/run" /proc/mounts; then
	as_root mount -vt tmpfs tmpfs $LFS/run
fi

if ! grep -qs "$LFS/Home" /proc/mounts; then
	as_root mount -t prl_fs Home $LFS/Home
fi

if [ -h $LFS/dev/shm ]; then
	as_root mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi
