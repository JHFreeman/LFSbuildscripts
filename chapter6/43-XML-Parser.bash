#!/bin/bash -e

source try_unpack.bash



export PKGDIR="XML-Parser-2.44"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

perl Makefile.PL

make

make install

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
echo "./43-XML-Parser.sh ran"
source 44-autoconf.sh
