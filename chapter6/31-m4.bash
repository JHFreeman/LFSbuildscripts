#!/tools/bin/bash -e

source try_unpack.bash

export PKGDIR="m4-1.4.17"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr

make

make install

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
echo "./31-m4.sh ran"
