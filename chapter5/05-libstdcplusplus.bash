#!/bin/bash -e

export PKGNAME="gcc"
export PKGVER="5.1.0"

trap 'echo '$PKGNAME'-'$PKGVER'; times' EXIT

export LFS=/mnt/lfs

source try_unpack.bash

pushd $LFS/sources

if [ -d $PKGNAME-$PKGVER ]; then
	rm -rf $PKGNAME-$PKGVER
fi
if [ -d $PKGNAME-build ]; then
	rm -rf $PKGNAME-build
fi

try_unpack $PKGNAME-$PKGVER

cd $PKGNAME-$PKGVER

mkdir -pv ../$PKGNAME-build
cd ../$PKGNAME-build

CFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
../$PKGNAME-$PKGVER/libstdc++-v3/configure \
    --host=$LFS_TGT                 \
    --prefix=/tools                 \
    --disable-multilib              \
    --disable-nls                   \
    --disable-libstdcxx-threads     \
    --disable-libstdcxx-pch         \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/$PKGVER
    
make

make install

cd ..

rm -rf $PKGNAME-$PKGVER $PKGNAME-build

unset PKGNAME PKGVER

popd