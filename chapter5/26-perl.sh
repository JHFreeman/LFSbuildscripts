#!/bin/bash -e

export PKGNAME="perl"
export PKGVER="5.20.2"

export LFS=/mnt/lfs

source as_root.sh

pushd $LFS/sources

if [ -d $PKGNAME-$PKGVER ]; then
	rm -rf $PKGNAME-$PKGVER
fi

try_unpack $PKGNAME-$PKGVER

cd $PKGNAME-$PKGVER

sh Configure -des -Dprefix=/tools -Dlibs=-lm

make

as_root cp -v perl cpan/podlators/pod2man /tools/bin
as_root mkdir -pv /tools/lib/perl5/5.20.2
as_root cp -Rv lib/* /tools/lib/perl5/5.20.2

cd ..

rm -rf $PKGNAME-$PKGVER

echo "$PKGNAME-$PKGVER"

unset PKGNAME PKGVER

popd