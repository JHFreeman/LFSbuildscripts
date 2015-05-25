#!/bin/bash -e

LFS=/mnt/lfs

pushd $LFS/sources

wget http://www.nico.schottelius.org/software/gpm/archives/gpm-1.20.7.tar.bz2

wget ftp://ftp.isc.org/isc/dhcp/4.3.1/dhcp-4.3.1.tar.gz

wget http://www.linuxfromscratch.org/patches/blfs/systemd/dhcp-4.3.1-client_script-1.patch

wget http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-6.7p1.tar.gz

wget ftp://ftp.openssl.org/source/openssl-1.0.2.tar.gz

wget http://www.linuxfromscratch.org/patches/blfs/systemd/openssl-1.0.2-fix_parallel_build-1.patch

wget http://ftp.gnu.org/gnu/wget/wget-1.16.1.tar.xz

wget http://www.linuxfromscratch.org/blfs/downloads/systemd/blfs-systemd-units-20150210.tar.bz2

tar -xf blfs-systemd-units-20150210.tar.bz2

popd