#!/bin/bash

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="tar-1.28"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

FORCE_UNSAFE_CONFIGURE=1  \
./configure --prefix=/usr \
            --bindir=/bin
            
make

make install
make -C doc install-html docdir=/usr/share/doc/tar-1.28

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./67-tar.sh ran"
