#!/bin/bash

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="gzip-1.6"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr --bindir=/bin

make

make install

mv -v /bin/{gzexe,uncompress,zcmp,zdiff,zegrep} /usr/bin
mv -v /bin/{zfgrep,zforce,zgrep,zless,zmore,znew} /usr/bin

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./56-gzip.sh ran"
