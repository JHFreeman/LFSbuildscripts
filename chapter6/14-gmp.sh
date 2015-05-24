#!/tools/bin/bash -e

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="gmp-6.0.0"

cd /sources

try_unpack $PKGDIR"a"

cd $PKGDIR

./configure --prefix=/usr \
            --enable-cxx  \
            --docdir=/usr/share/doc/gmp-6.0.0a
                           
make
make html

make install
make install-html

cd ..

rm -rf $PKGDIR

cd $PREV_DIR

unset PREV_DIR PKGDIR

echo "./14-gmp.sh ran"
