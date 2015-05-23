#!/bin/bash

export PKGNAME="bzip2"
export PKGVER="1.0.6"

export LFS=/mnt/lfs

pushd $LFS/sources

if [ -d $PKGNAME-$PKGVER ]; then
	rm -rf $PKGNAME-$PKGVER
fi

try_unpack $PKGNAMe-$PKGVER

cd $PKGNAME-$PKGVER

make

make PREFIX=/tools install

cd ..

rm -rf $PKGNAME-$PKGVER

echo "$PKGNAME-$PKGVER"

unset PKGNAME PKGVER

popd