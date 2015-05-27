#!/bin/bash -e

source try_unpack.bash



export PKGDIR="libpipeline-1.4.0"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr

make

make install

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
echo "./60-libpipeline.sh ran"
