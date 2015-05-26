#!/bin/bash -e

LFS=/mnt/lfs

pushd $LFS/sources

wget http://www.nico.schottelius.org/software/gpm/archives/gpm-1.20.7.tar.bz2

wget ftp://ftp.isc.org/isc/dhcp/4.3.2/dhcp-4.3.2.tar.gz

wget http://www.linuxfromscratch.org/patches/blfs/svn/dhcp-4.3.2-client_script-1.patch

wget http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-6.8p1.tar.gz

wget ftp://ftp.openssl.org/source/openssl-1.0.2a.tar.gz

wget http://www.linuxfromscratch.org/patches/blfs/svn/openssl-1.0.2a-fix_parallel_build-2.patch

wget http://ftp.gnu.org/gnu/wget/wget-1.16.3.tar.xz

URL=http://www.linuxfromscratch.org/blfs/downloads/svn/blfs-bootscripts-20150304.tar.bz2

wget $URL

tar -xf ${URL##*/}

popd