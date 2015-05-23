#!/bin/bash

export PKGNAME="binutils"
export PKGVER="2.25"

export LFS=/mnt/lfs

pushd $LFS/sources

if [ -d $PKGNAME-$PKGVER ]; then
	rm -rf $PKGNAME-$PKGVER
fi

if [ -d $PKGNAME-build ]; then
	rm -rf $PKGNAME-build
fi

try_unpack $PKGNAME-$PKGVER

mkdir $PKGNAME-build

cd $PKGNAME-build

../binutils-2.25/configure \
	--prefix=/tools \
	--with-sysroot=$LFS \
	--with-lib-path=/tools/lib \
	--target=$LFS_TGT \
	--disable-nls \
	--disable-werror
	
make

case $(uname -m) in
	x86_64) mkdir -v /tools/lib && ln -sv lib /tools/lib ;;
esac

make install

cd ..

rm -rf binutils-build binutils-2.25

echo "$PKGNAME-$PKGVER pass #1"

unset PKGNAME PKGVER

popd