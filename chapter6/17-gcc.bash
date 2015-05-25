#!/tools/bin/bash -e

source try_unpack.bash



export PKGNAME="gcc"
export PKGDIR="gcc-4.9.2"

pushd /sources

try_unpack $PKGDIR

mkdir $PKGNAME-build
cd $PKGNAME-build

SED=sed                       \
../$PKGDIR/configure        \
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
ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/4.9.2/liblto_plugin.so /usr/lib/bfd-plugins/

echo 'main(){}' > dummy.c
cc dummy.c -v -Wl,--verbose &> dummy.log
readelf -l a.out | grep ': /lib' >> ../gcc-4.9.2.log

grep -o '/usr/lib.*/crt[1in].*succeeded' dummy.log >> ../gcc-4.9.2.log

grep -B4 '^ /usr/include' dummy.log >> ../gcc-4.9.2.log

grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g' >> ../gcc-4.9.2.log

grep "/lib.*/libc.so.6 " dummy.log >> ../gcc-4.9.2.log

cd ..

rm -rf $PKGDIR $PKGNAME-build

mkdir -pv /usr/share/gdb/auto-load/usr/lib
mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib

popd

unset  PKGDIR PKGNAME
echo "./17-gcc.sh ran"
