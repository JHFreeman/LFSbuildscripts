#!/tools/bin/bash -e

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="readline-6.3"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

patch -Np1 -i ../readline-6.3-upstream_fixes-3.patch

sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install

./configure --prefix=/usr --docdir=/usr/share/doc/readline-6.3

make SHLIB_LIBS=-lncurses

make SHLIB_LIBS=-lncurses install

mv -v /usr/lib/lib{readline,history}.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libreadline.so) /usr/lib/libreadline.so
ln -sfv ../../lib/$(readlink /usr/lib/libhistory.so ) /usr/lib/libhistory.so

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./35-readline.sh ran"
