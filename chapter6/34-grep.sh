#!/tools/bin/bash -e

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="grep-2.21"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

sed -i -e '/tp++/a  if (ep <= tp) break;' src/kwset.c

./configure --prefix=/usr --bindir=/bin

make

make install

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./34-grep.sh ran"
