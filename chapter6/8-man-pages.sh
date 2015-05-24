#!/tools/bin/bash -e

source try_unpack.sh

export PKGDIR="man-pages-3.79"

export PREV_DIR=$PWD

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

make install

cd ..

rm -rf $PKGDIR

cd $PREV_DIR

unset PREV_DIR PKGNAME
echo "./8-man-pages.sh ran"
