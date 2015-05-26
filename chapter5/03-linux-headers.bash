#!/bin/bash -e

export PKGNAME="linux"
export PKGVER="4.0.3"

export LFS=/mnt/lfs

source try_unpack.bash

pushd $LFS/sources

if [ -d $PKGNAME-$PKGVER ]; then
	rm -rf $PKGNAME-$PKGVER
fi

try_unpack $PKGNAME-$PKGVER

cd $PKGNAME-$PKGVER

make mrproper

make INSTALL_HDR_PATH=dest headers_install
cp -rv dest/include/* /tools/include

cd ..

rm -rf $PKGNAME-$PKGVER

echo "$PKGNAME-$PKGVER headers"

unset PKGNAME PKGVER

popd
