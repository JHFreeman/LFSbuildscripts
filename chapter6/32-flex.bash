#!/tools/bin/bash -e

source try_unpack.bash

export PKGDIR="flex-2.5.39"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

sed -i -e '/test-bison/d' tests/Makefile.in

./configure --prefix=/usr --docdir=/usr/share/doc/flex-2.5.39

make

make install

ln -sv flex /usr/bin/lex

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
echo "./32-flex.sh ran"
