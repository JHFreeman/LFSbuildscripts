#!/bin/bash -e

source try_unpack.bash


export PKGDIR="findutils-4.4.2"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr --localstatedir=/var/lib/locate

make

make install

mv -v /usr/bin/find /bin
sed -i 's|find:=${BINDIR}|find:=/bin|' /usr/bin/updatedb

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
echo "./48-findutils.sh ran"
