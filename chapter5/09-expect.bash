#!/bin/bash -e

export PKGNAME="expect"
export PKGVER="5.45"

export LFS=/mnt/lfs



source try_unpack.bash

pushd $LFS/sources

if [ -d $PKGNAME$PKGVER ]; then
	rm -rf $PKGNAME$PKGVER
fi

try_unpack $PKGNAME$PKGVER

cd $PKGNAME$PKGVER

cp -v configure{,.orig}

sed 's:/usr/local/bin:/bin:' configure.orig > configure

./configure --prefix=/tools \
	--with-tcl=/tools/lib \
	--with-tclinclude=/tools/include
	
make

make SCRIPTS="" install

cd ..

rm -rf $PKGNAME$PKGVER

echo "$PKGNAME$PKGVER"

unset PKGNAME PKGVER

popd
