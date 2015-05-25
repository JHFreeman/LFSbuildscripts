#!/tools/bin/bash -e

source try_unpack.bash

export PKGDIR="grep-2.21"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

sed -i -e '/tp++/a  if (ep <= tp) break;' src/kwset.c

./configure --prefix=/usr --bindir=/bin

make

make install

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
echo "./34-grep.sh ran"
