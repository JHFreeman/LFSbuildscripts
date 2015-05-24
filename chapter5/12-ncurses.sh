#!/bin/bash -e

export PKGNAME="ncurses"
export PKGVER="5.9"

export LFS=/mnt/lfs

source as_root.sh

pushd $LFS/sources

if [ -d $PKGNAME-$PKGVER ]; then
	rm -rf $PKGNAME-$PKGVER
fi

try_unpack $PKGNAME-$PKGVER

cd $PKGNAME-$PKGVER

./configure --prefix=/tools \
            --with-shared   \
            --without-debug \
            --without-ada   \
            --enable-widec  \
            --enable-overwrite
            
make

as_root make install

cd ..

rm -rf $PKGNAME-$PKGVER

echo "$PKGNAME-$PKGVER"

unset PKGNAME PKGVER

popd