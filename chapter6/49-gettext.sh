#!/bin/bash

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="gettext-0.19.4"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr --docdir=/usr/share/doc/gettext-0.19.4

make

make install

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./49-gettext.sh ran"
