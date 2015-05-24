#!/tools/bin/bash -e

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="pkg-config-0.28"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr        \
            --with-internal-glib \
            --disable-host-tool  \
            --docdir=/usr/share/doc/pkg-config-0.28
            
make

make install

cd ..

rm -rf $PKGDIR

cd $PREV_DIR

unset PREV_DIR PKGNAME
echo "./19-pkg-config.sh ran"
