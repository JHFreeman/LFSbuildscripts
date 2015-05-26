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

CC=$LFS_TGT-gcc                \
AR=$LFS_TGT-ar                 \
RANLIB=$LFS_TGT-ranlib         \
../binutils-2.25/configure     \
    --prefix=/tools            \
    --disable-nls              \
    --disable-werror           \
    --with-lib-path=/tools/lib \
    --with-sysroot
    
make

make install

make -C ld clean
make -C ld LIB_PATH=/usr/lib:/lib

ld/ld-new --verbose | grep SEARCH_DIR

cp -v ld/ld-new /tools/bin

cd ..

rm -rf $PKGNAME-build $PKGNAME-$PKGVER

echo "$PKGNAME-$PKGVER pass #2"

unset PKGNAME PKGVER

popd
