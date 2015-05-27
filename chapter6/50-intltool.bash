#!/bin/bash -e

source try_unpack.bash



export PKGDIR="intltool-0.51.0"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr

make

make install
install -v -Dm644 doc/I18N-HOWTO /usr/share/doc/intltool-0.50.2/I18N-HOWTO

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
echo "./50-intltool.sh ran"
