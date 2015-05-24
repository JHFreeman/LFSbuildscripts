#!/tools/bin/bash -e

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="sed-4.2.2"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr --bindir=/bin --htmldir=/usr/share/doc/sed-4.2.2

make
make html

make install
make -C doc install-html

cd ..

rm -rf $PKGDIR

cd $PREV_DIR

unset PREV_DIR PKGDIR
echo "./24-sed.sh ran"
