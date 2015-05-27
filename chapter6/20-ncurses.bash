#!/tools/bin/bash -e

source try_unpack.bash

export MAKEFLAGS='-j 3'
export CFLAGS="-march=native -pipe -O2 -fstack-protector-strong -mavx"
export CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong -mavx"

export PKGDIR="ncurses-5.9"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

if [ -d $PKGDIR ]; then
	rm -rf $PKGDIR
fi

try_unpack $PKGDIR

cd $PKGDIR

patch -Np1 -i ../ncurses-5.9-gcc5_buildfixes-1.patch

./configure --prefix=/usr           \
            --mandir=/usr/share/man \
            --with-shared           \
            --without-debug   		\
            --without-normal        \
            --enable-pc-files       \
            --enable-widec
            
make

make install

mv -v /usr/lib/libncursesw.so.5* /lib

ln -sfv ../../lib/$(readlink /usr/lib/libncursesw.so) /usr/lib/libncursesw.so

for lib in ncurses form panel menu ; do
    rm -vf                    /usr/lib/lib${lib}.so
    echo "INPUT(-l${lib}w)" > /usr/lib/lib${lib}.so
    ln -sfv ${lib}w.pc        /usr/lib/pkgconfig/${lib}.pc
done

rm -vf                     /usr/lib/libcursesw.so
echo "INPUT(-lncursesw)" > /usr/lib/libcursesw.so
ln -sfv libncurses.so      /usr/lib/libcurses.so

cd ..

rm -rf $PKGDIR

popd

unset  PKGDIR
unset CFLAGS CXXFLAGS