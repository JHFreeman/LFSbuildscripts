#!/tools/bin/bash -e

source try_unpack.bash

export PKGDIR="gmp-6.0.0"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGDIR"a"

cd $PKGDIR

CFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
./configure --prefix=/usr \
            --enable-cxx  \
            --docdir=/usr/share/doc/gmp-6.0.0a
                           
make
make html

make install
make install-html

cd ..

rm -rf $PKGDIR

popd

unset  PKGDIR

