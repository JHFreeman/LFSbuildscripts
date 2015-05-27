#!/bin/bash -e

export THISDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )



LFS=/mnt/lfs

if [ ! -h $LFS/linuxbuild ]; then
	ln -sv /Home/linuxbuild $LFS/linuxbuild
fi

/usr/sbin/chroot "$LFS" /tools/bin/env -i \
	HOME=/root \
	TERM="$TERM" \
	PS1='\u:\w\$ ' \
	PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
	/tools/bin/bash --login +h /Home/Documents/linuxbuild/chapter6/00-build.bash 2

cd /

#umount -v $LFS/dev/pts
#umount -v $LFS/dev
#umount -v $LFS/run
#umount -v $LFS/proc
#umount -v $LFS/sys
#umount -v $LFS/Home
#umount -v $LFS

#shutdown -r now
