#!/bin/bash -e

export PKGNAME="bzip2"
export PKGVER="1.0.6"

export LFS=/mnt/lfs

source as_root.sh

pushd $LFS/sources

if [ -d $PKGNAME-$PKGVER ]; then
	rm -rf $PKGNAME-$PKGVER
fi

try_unpack $PKGNAME-$PKGVER

cd $PKGNAME-$PKGVER

make

as_root make PREFIX=/tools install

cd ..

rm -rf $PKGNAME-$PKGVER

echo "$PKGNAME-$PKGVER"

unset PKGNAME PKGVER

popd