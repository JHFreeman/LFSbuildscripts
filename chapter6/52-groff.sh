#!/bin/bash

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="groff-1.22.3"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

PAGE=letter ./configure --prefix=/usr

make

make install

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./52-groff.sh ran"
