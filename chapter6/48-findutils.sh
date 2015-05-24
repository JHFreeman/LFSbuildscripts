#!/bin/bash

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="findutils-4.4.2"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr --localstatedir=/var/lib/locate

make

make insatll

mv -v /usr/bin/find /bin
sed -i 's|find:=${BINDIR}|find:=/bin|' /usr/bin/updatedb

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./48-findutils.sh ran"
