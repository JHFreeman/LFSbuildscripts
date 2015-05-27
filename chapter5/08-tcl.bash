#!/bin/bash -e

export PKGNAME="tcl"
export PKGVER="8.6.4"
trap 'echo '$PKGNAME'-'$PKGVER'; times' EXIT

export LFS=/mnt/lfs



source try_unpack.bash

pushd $LFS/sources

if [ -d $PKGNAME$PKGVER ]; then
	rm -rf $PKGNAME$PKGVER
fi

try_unpack $PKGNAME-core$PKGVER"-src"

cd $PKGNAME$PKGVER

cd unix

CFLAGS="-march=native -pipe -O2 -fstack-protector-strong -mavx" \
CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong -mavx" \
./configure --prefix=/tools

make

make install

chmod -v u+w /tools/lib/libtcl8.6.so

make install-private-headers

ln -sv tclsh8.6 /tools/bin/tclsh

cd ../..

rm -rf $PKGNAME$PKGVER


unset PKGNAME PKGVER

popd