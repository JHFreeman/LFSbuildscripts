#!/bin/bash -e

export THISDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source as_root.bash

LFS=/mnt/lfs

if [ ! -h $LFS/linuxbuild ]; then
	as_root ln -sv /Home/linuxbuild $LFS/linuxbuild
fi

as_root /usr/sbin/chroot "$LFS" /tools/bin/env -i \
	HOME=/root \
	TERM="$TERM" \
	PS1='\u:\w\$ ' \
	PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
	/tools/bin/bash --login +h

cd /

#as_root umount -v $LFS/dev/pts
#as_root umount -v $LFS/dev
#as_root umount -v $LFS/run
#as_root umount -v $LFS/proc
#as_root umount -v $LFS/sys
#as_root umount -v $LFS/Home
#as_root umount -v $LFS

#as_root shutdown -r now
