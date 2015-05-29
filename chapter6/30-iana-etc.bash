#!/tools/bin/bash -e

source try_unpack.bash

export PKGDIR="iana-etc-2.30"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

make

make install

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
