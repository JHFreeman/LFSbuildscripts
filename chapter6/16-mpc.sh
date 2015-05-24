#!/tools/bin/bash -e

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="mpc-1.0.2"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr --docdir=/usr/share/doc/mpc-1.0.2
                           
make
make html

make install
make install-html

cd ..

rm -rf $PKGDIR

cd $PREV_DIR

unset PREV_DIR PKGDIR
echo "./16-mpc.sh ran"
