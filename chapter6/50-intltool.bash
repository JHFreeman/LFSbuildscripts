#!/bin/bash -e

source try_unpack.bash

export MAKEFLAGS='-j 3'
export CFLAGS="-march=native -pipe -O2 -mavx -fstack-protector-strong"
export CXXFLAGS="-march=native -pipe -O2 -mavx -fstack-protector-strong"

export PKGDIR="intltool-0.51.0"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

if [ -d $PKGDIR ]; then
	rm -rf $PKGDIR
fi

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
unset CFLAGS CXXFLAGS