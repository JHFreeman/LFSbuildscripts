#!/bin/bash -e

source try_unpack.bash

export PKGDIR="intltool-0.51.0"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

if [ -d $PKGDIR ]; then
	rm -rf $PKGDIR
fi

try_unpack $PKGDIR

cd $PKGDIR

CFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
./configure --prefix=/usr

make

make install
install -v -Dm644 doc/I18N-HOWTO /usr/share/doc/intltool-0.50.2/I18N-HOWTO

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
