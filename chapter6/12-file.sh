#!/tools/bin/bash -e

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="file-5.22"

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
echo "./12-file.sh ran"
