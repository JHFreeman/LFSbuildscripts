#!/bin/bash -e

export PKGNAME="gcc"
export PKGVER="4.9.2"

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

../gcc-4.9.2/libstdc++-v3/configure \
    --host=$LFS_TGT                 \
    --prefix=/tools                 \
    --disable-multilib              \
    --disable-shared                \
    --disable-nls                   \
    --disable-libstdcxx-threads     \
    --disable-libstdcxx-pch         \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/4.9.2
    
make

make install

cd ..

rm -rf $PKGNAME-$PKGVER $PKGNAME-build

echo "$PKGNAME-$PKGVER: libstdc++"

unset PKGNAME PKGVER

popd