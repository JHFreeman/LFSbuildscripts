#!/tools/bin/bash -e

source try_unpack.bash

export PKGDIR="mpc-1.0.3"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

CFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
./configure --prefix=/usr --docdir=/usr/share/doc/mpc-1.0.3
                           
make
make html

make install
make install-html

cd ..

rm -rf $PKGDIR

popd

unset  PKGDIR
