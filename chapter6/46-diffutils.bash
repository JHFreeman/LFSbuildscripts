#!/bin/bash -e

source try_unpack.bash



export PKGDIR="diffutils-3.3"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

sed -i 's:= @mkdir_p@:= /bin/mkdir -p:' po/Makefile.in.in

./configure --prefix=/usr

make

make install

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
echo "./46-diffutils.sh ran"
