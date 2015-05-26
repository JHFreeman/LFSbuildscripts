#!/bin/bash -e

export PKGNAME="tcl-core"
export PKGVER="8.6.3"

export LFS=/mnt/lfs



source try_unpack.bash

pushd $LFS/sources

if [ -d $PKGNAME$PKGVER ]; then
	rm -rf $PKGNAME$PKGVER
fi

try_unpack $PKGNAME$PKGVER"-src"

cd $PKGNAME$PKGVER

cd unix

./configure --prefix=/tools

make

make install

chmod -v u+w /tools/lib/libtcl8.6.so

make install-private-headers

ln -sv tclsh8.6 /tools/bin/tclsh

cd ../..

rm -rf $PKGNAME$PKGVER

echo "$PKGNAME-$PKGVER"

unset PKGNAME PKGVER

popd
