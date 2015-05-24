#!/bin/bash -e

export PKGNAME="gcc"
export PKGVER="4.9.2"

export LFS=/mnt/lfs

source as_root.sh

pushd $LFS/sources

if [ -d $PKGNAME-$PKGVER ]; then
	rm -rf $PKGNAME-$PKGVER
fi
if [ -d $PKGNAME-build ]; then
	as_root rm -rf $PKGNAME-build
fi

try_unpack $PKGNAME-$PKGVER

cd $PKGNAME-$PKGVER

mkdir -pv ../$PKGNAME-build
cd ../$PKGNAME-build

as_root ../$PKGNAME-$PKGVER/libstdc++-v3/configure \
    --host=$LFS_TGT                 \
    --prefix=/tools                 \
    --disable-multilib              \
    --disable-shared                \
    --disable-nls                   \
    --disable-libstdcxx-threads     \
    --disable-libstdcxx-pch         \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/4.9.2
    
as_root make

as_root make install

cd ..

as_root rm -rf $PKGNAME-$PKGVER $PKGNAME-build

echo "$PKGNAME-$PKGVER: libstdc++"

unset PKGNAME PKGVER

popd