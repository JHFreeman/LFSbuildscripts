#!/bin/bash

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="intltool-0.50.2"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr

make

make install
install -v -Dm644 doc/I18N-HOWTO /usr/share/doc/intltool-0.50.2/I18N-HOWTO

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./50-intltool.sh ran"
