#!/bin/bash -e

source ../as_root.sh

as_root chroot "$LFS" /tools/bin/env -i \
	HOME=/root \
	TERM="$TERM" \
	PS1='\u:\w\$ ' \
	PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
	/tools/bin/bash --login +h
	
as_root umount -v $LFS/dev/pts
as_root umount -v $LFS/dev
as_root umount -v $LFS/run
as_root umount -v $LFS/proc
as_root umount -v $LFS/sys

as_root umount -v $LFS

as_root shutdown -r now
