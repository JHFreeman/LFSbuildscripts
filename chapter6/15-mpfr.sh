#!/tools/bin/bash -e

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="mpfr-3.1.2"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

patch -Np1 -i ../mpfr-3.1.2-upstream_fixes-3.patch

./configure --prefix=/usr \
            --enable-thread-safe  \
            --docdir=/usr/share/doc/mpfr-3.1.2
                           
make
make html

make install
make install-html

cd ..

rm -rf $PKGDIR

cd $PREV_DIR

unset PREV_DIR PKGDIR
echo "./15-mpfr.sh ran"
