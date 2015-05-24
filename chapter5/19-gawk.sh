#!/bin/bash -e

export PKGNAME="gawk"
export PKGVER="4.1.1"

export LFS=/mnt/lfs

source as_root.sh

pushd $LFS/sources

if [ -d $PKGNAME-$PKGVER ]; then
	rm -rf $PKGNAME-$PKGVER
fi

try_unpack $PKGNAME-$PKGVER

cd $PKGNAME-$PKGVER

./configure --prefix=/tools

make

as_root make install

cd ..

rm -rf $PKGNAME-$PKGVER

echo "$PKGNAME-$PKGVER"

unset PKGNAME PKGVER

popd