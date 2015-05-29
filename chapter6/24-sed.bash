#!/tools/bin/bash -e

source try_unpack.bash

export PKGDIR="sed-4.2.2"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

CFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
./configure --prefix=/usr --bindir=/bin --htmldir=/usr/share/doc/sed-4.2.2

make
make html

make install
make -C doc install-html

cd ..

rm -rf $PKGDIR

popd

unset  PKGDIR
