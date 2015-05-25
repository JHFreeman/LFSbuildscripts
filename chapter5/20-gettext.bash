#!/bin/bash -e

export PKGNAME="gettext"
export PKGVER="0.19.4"

export LFS=/mnt/lfs



source try_unpack.bash

pushd $LFS/sources

if [ -d $PKGNAME-$PKGVER ]; then
	rm -rf $PKGNAME-$PKGVER
fi

try_unpack $PKGNAME-$PKGVER

cd $PKGNAME-$PKGVER

cd gettext-tools

EMACS="no" ./configure --prefix=/tools --disable-shared

make -C gnulib-lib
make -C intl pluralx.c
make -C src msgfmt
make -C src msgmerge
make -C src xgettext

cp -v src/{msgfmt,msgmerge,xgettext} /tools/bin

cd ../..

rm -rf $PKGNAME-$PKGVER

echo "$PKGNAME-$PKGVER"

unset PKGNAME PKGVER

popd
