#!/tools/bin/bash -e

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="m4-1.4.17"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr

make

make install

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./31-m4.sh ran"
