#!/bin/bash

pushd /sources

export PKGDIR="openssl-1.0.2a"
export CFLAGS="-march=native -pipe -O2 -fstack-protector-strong -mavx"
export CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong -mavx"
trap 'echo '$PKGDIR'; times' EXIT
try_unpack $PKGDIR

cd $PKGDIR

patch -Np1 -i ../openssl-1.0.2a-fix_parallel_build-2.patch &&

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