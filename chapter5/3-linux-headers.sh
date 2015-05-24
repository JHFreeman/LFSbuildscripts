#!/bin/bash -e

export PKGNAME="linux"
export PKGVER="3.19"

export LFS=/mnt/lfs

source as_root.sh

pushd $LFS/sources

if [ -d $PKGNAME-$PKGVER ]; then
	rm -rf $PKGNAME-$PKGVER
fi

try_unpack $PKGNAME-$PKGVER

cd $PKGNAME-$PKGVER

make mrproper

make INSTALL_HDR_PATH=dest headers_install
as_root cp -rv dest/include/* /tools/include

cd ..

rm -rf $PKGNAME-$PKGVER

echo "$PKGNAME-$PKGVER headers"

unset PKGNAME PKGVER

popd