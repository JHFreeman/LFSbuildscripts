#!/tools/bin/bash -e

source try_unpack.bash

export MAKEFLAGS='-j 3'
export CFLAGS="-march=native -pipe -O2 -fstack-protector-strong -mavx"
export CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong -mavx"

export PKGDIR="flex-2.5.39"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

sed -i -e '/test-bison/d' tests/Makefile.in

./configure --prefix=/usr --docdir=/usr/share/doc/flex-2.5.39

make

make install

if [ -h /usr/bin/lex ]; then
	rm /usr/bin/lex
fi

ln -sv flex /usr/bin/lex

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR CFLAGS CXXFLAGS
unset CFLAGS CXXFLAGS