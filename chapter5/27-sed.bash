#!/bin/bash -e

export PKGNAME="sed"
export PKGVER="4.2.2"

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
./configure --prefix=/tools

make

make install

cd ..

rm -rf $PKGNAME-$PKGVER

echo "$PKGNAME-$PKGVER"

unset PKGNAME PKGVER

popd
