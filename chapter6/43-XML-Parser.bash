#!/bin/bash -e

source try_unpack.bash

export PKGDIR="XML-Parser-2.44"

trap 'echo '$PKGDIR'; times' EXIT

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
