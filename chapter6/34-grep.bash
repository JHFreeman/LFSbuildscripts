#!/tools/bin/bash -e

source try_unpack.bash

export PKGDIR="grep-2.21"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

sed -i -e '/tp++/a  if (ep <= tp) break;' src/kwset.c

CFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
./configure --prefix=/usr --bindir=/bin

make

make install

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR CFLAGS CXXFLAGS
