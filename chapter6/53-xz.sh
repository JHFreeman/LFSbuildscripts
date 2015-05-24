#!/bin/bash

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="xz-5.2.0"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr --docdir=/usr/share/doc/xz-5.2.0

make

make install
mv -v   /usr/bin/{lzma,unlzma,lzcat,xz,unxz,xzcat} /bin
mv -v /usr/lib/liblzma.so.* /lib
ln -svf ../../lib/$(readlink /usr/lib/liblzma.so) /usr/lib/liblzma.so

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./53-xz.sh ran"
