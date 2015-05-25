#!/bin/bash -e

export PKGNAME="binutils"
export PKGVER="2.25"

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

mkdir -v ../$PKGNAME-build
cd ../$PKGNAME-build

CC=/tools/bin/$LFS_TGT-gcc                \
AR=/tools/bin/$LFS_TGT-ar                 \
RANLIB=/tools/bin/$LFS_TGT-ranlib         \
../$PKGNAME-$PKGVER/configure     \
    --prefix=/tools            \
    --disable-nls              \
    --disable-werror           \
    --with-lib-path=/tools/lib \
    --with-sysroot
    
make

make install

make -C ld clean
make -C ld LIB_PATH=/usr/lib:/lib
cp -v ld/ld-new /tools/bin

cd ..

rm -rf $PKGNAME-build $PKGNAME-$PKGVER

echo "$PKGNAME-$PKGVER pass #2"

unset PKGNAME PKGVER

popd
