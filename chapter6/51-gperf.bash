#!/bin/bash -e

source try_unpack.bash



export PKGDIR="gperf-3.0.4"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr --docdir=/usr/share/doc/gperf-3.0.4

make

make install

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
echo "./51-gperf.sh ran"
