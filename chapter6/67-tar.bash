#!/bin/bash -e

source try_unpack.bash



export PKGDIR="tar-1.28"

pushd /sources

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
popd
unset  PKGDIR
echo "./67-tar.sh ran"
