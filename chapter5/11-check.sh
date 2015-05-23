#!/bin/bash

export PKGNAME="check"
export PKGVER="0.9.14"

export LFS=/mnt/lfs

pushd $LFS/sources

if [ -d $PKGNAME-$PKGVER ]; then
	rm -rf $PKGNAME-$PKGVER
fi

try_unpack $PKGNAME-$PKGVER

cd $PKGNAME-$PKGVER

PKG_CONFIG= ./configure --prefix=/tools

make

make install

cd ..

rm -rf $PKGNAM-$PKGVER

echo "$PKGNAME-$PKGVER"

unset PKGNAME PKGVER

popd