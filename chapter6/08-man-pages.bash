#!/tools/bin/bash -e

source try_unpack.bash

export PKGDIR="man-pages-4.00"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

make install

cd ..

rm -rf $PKGDIR

popd

unset  PKGNAME
echo "./8-man-pages.sh ran"
