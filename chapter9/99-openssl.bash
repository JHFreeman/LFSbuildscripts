#!/bin/bash

pushd /sources

export PKGDIR="openssl-1.0.2"

try_unpack $PKGDIR

cd $PKGDIR

patch -Np1 -i ../openssl-1.0.2-fix_parallel_build-1.patch &&

./config --prefix=/usr         \
         --openssldir=/etc/ssl \
         --libdir=lib          \
         shared                \
         zlib-dynamic &&
make

sed -i 's# libcrypto.a##;s# libssl.a##' Makefile

make MANDIR=/usr/share/man MANSUFFIX=ssl install &&
if [ ! -d /usr/share/doc/openssl-1.0.2 ]; then
install -dv -m755 /usr/share/doc/openssl-1.0.2
fi  &&
cp -vfr doc/*     /usr/share/doc/openssl-1.0.2

cd ..

rm -rf $PKGDIR

popd