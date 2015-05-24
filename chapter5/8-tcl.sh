#!/bin/bash -e

export PKGNAME="tcl"
export PKGVER="8.6.3"

export LFS=/mnt/lfs

source as_root.sh

pushd $LFS/sources

if [ -d $PKGNAME$PKGVER ]; then
	rm -rf $PKGNAME$PKGVER
fi

try_unpack $PKGNAME$PKGVER"-src"

cd $PKGNAME$PKGVER

cd unix

./configure --prefix=/tools

make

as_root make install

as_root chmod -v u+w /tools/lib/libtcl8.6.so

as_root make install-private-headers

as_root ln -sv tclsh8.6 /tools/bin/tclsh

cd ../..

rm -rf $PKGNAME$PKGVER

echo "$PKGNAME-$PKGVER"

unset PKGNAME PKGVER

popd