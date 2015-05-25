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

mkdir $PKGNAME-build

cd $PKGNAME-build

../$PKGNAME-$PKGVER/configure \
	--prefix=/tools \
	--with-sysroot=$LFS \
	--with-lib-path=/tools/lib \
	--target=$LFS_TGT \
	--disable-nls \
	--disable-werror
	
make

case $(uname -m) in
	x86_64) mkdir -v /tools/lib && ln -sv lib /tools/lib64 ;;
esac

make install

cd ..

rm -rf $PKGNAME-build $PKGNAME-$PKGVER

echo "$PKGNAME-$PKGVER pass #1"

unset PKGNAME PKGVER

popd