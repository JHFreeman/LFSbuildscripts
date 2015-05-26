#!/tools/bin/bash -e

source try_unpack.bash

export PKGDIR="man-pages-3.79"



pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

make install

cd ..

rm -rf $PKGDIR

popd

unset  PKGNAME
echo "./8-man-pages.sh ran"
