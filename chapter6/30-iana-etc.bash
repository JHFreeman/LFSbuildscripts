#!/tools/bin/bash -e

source try_unpack.bash

export PKGDIR="iana-etc-2.30"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

make

make install

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
echo "./30-iana-etc.sh ran"
