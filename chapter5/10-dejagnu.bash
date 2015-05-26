#!/bin/bash -e

export PKGNAME="dejagnu"
export PKGVER="1.5.3"

export LFS=/mnt/lfs



source try_unpack.bash

pushd $LFS/sources

if [ -d $PKGNAME-$PKGVER ]; then
	rm -rf $PKGNAME-$PKGVER
fi

try_unpack $PKGNAME-$PKGVER

cd $PKGNAME-$PKGVER

./configure --prefix=/tools

make install

cd ..

rm -rf $PKGNAME-$PKGVER

echo "$PKGNAME-$PKGVER"

unset PKGNAME PKGVER

popd
