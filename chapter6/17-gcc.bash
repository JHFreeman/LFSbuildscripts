#!/tools/bin/bash -e

source try_unpack.bash

export MAKEFLAGS='-j 3'
export CFLAGS="-march=native -pipe -O2 -fstack-protector-strong -mavx"
export CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong -mavx"

PKGNAME="gcc"
PKGVER="5.1.0"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGNAME-$PKGVER

mkdir $PKGNAME-build
cd $PKGNAME-build

SED=sed                       \
../$PKGNAME-$PKGVER/configure        \
     --prefix=/usr            \
     --enable-languages=c,c++ \
     --disable-multilib       \
     --disable-bootstrap      \
     --with-system-zlib
     
make

make install

ln -sv ../usr/bin/cpp /lib

ln -sv gcc /usr/bin/cc

install -v -dm755 /usr/lib/bfd-plugins
ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/$PKGVER/liblto_plugin.so /usr/lib/bfd-plugins/

echo 'main(){}' > dummy.c
cc dummy.c -v -Wl,--verbose &> dummy.log
readelf -l a.out | grep ': /lib'

grep -o '/usr/lib.*/crt[1in].*succeeded' dummy.log 
grep -B4 '^ /usr/include' dummy.log 

grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g' 
grep "/lib.*/libc.so.6 " dummy.log 

grep found dummy.log

rm -v dummy.c a.out dummy.log

cd ..

rm -rf $PKGDIR $PKGNAME-build

mkdir -pv /usr/share/gdb/auto-load/usr/lib
mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib

popd

unset  PKGDIR PKGNAME
unset CFLAGS CXXFLAGS