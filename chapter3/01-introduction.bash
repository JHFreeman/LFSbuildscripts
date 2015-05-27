#!/bin/bash -e

LFS=/mnt/lfs

if [ ! -d $LFS/sources ]; then
	mkdir -v $LFS/sources
fi

pushd $LFS/sources

chmod -v a+wt $LFS/sources

wget http://www.linuxfromscratch.org/lfs/view/systemd/wget-list

wget --input-file=$LFS/sources/wget-list --continue 

wget http://www.linuxfromscratch.org/lfs/view/systemd/md5sums

md5sum -c md5sums

popd