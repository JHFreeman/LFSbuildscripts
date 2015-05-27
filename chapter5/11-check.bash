#!/bin/bash -e

export PKGNAME="check"
export PKGVER="0.9.14"
trap 'echo '$PKGNAME'-'$PKGVER'; times' EXIT

export LFS=/mnt/lfs



source try_unpack.bash

pushd $LFS/sources

if [ -d $PKGNAME-$PKGVER ]; then
	rm -rf $PKGNAME-$PKGVER
fi

try_unpack $PKGNAME-$PKGVER

cd $PKGNAME-$PKGVER


CFLAGS="-march=native -pipe -O2 -fstack-protector-strong -mavx" \
CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong -mavx" \
PKG_CONFIG= ./configure --prefix=/tools

make

make install

cd ..

rm -rf $PKGNAME-$PKGVER

echo "$PKGNAME-$PKGVER"

unset PKGNAME PKGVER

popd