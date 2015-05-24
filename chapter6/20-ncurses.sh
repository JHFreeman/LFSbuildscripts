#!/tools/bin/bash -e

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="ncurses-5.9"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr           \
            --mandir=/usr/share/man \
            --with-shared           \
            --without-debug         \
            --enable-pc-files       \
            --enable-widec
            
make

make install

mv -v /usr/lib/libncursesw.so.5* /lib

ln -sfv ../../lib/$(readlink /usr/lib/libncursesw.so) /usr/lib/libncursesw.so

for lib in ncurses form panel menu ; do
    rm -vf                    /usr/lib/lib${lib}.so
    echo "INPUT(-l${lib}w)" > /usr/lib/lib${lib}.so
    ln -sfv lib${lib}w.a      /usr/lib/lib${lib}.a
    ln -sfv ${lib}w.pc        /usr/lib/pkgconfig/${lib}.pc
done

ln -sfv libncurses++w.a /usr/lib/libncurses++.a

rm -vf                     /usr/lib/libcursesw.so
echo "INPUT(-lncursesw)" > /usr/lib/libcursesw.so
ln -sfv libncurses.so      /usr/lib/libcurses.so
ln -sfv libncursesw.a      /usr/lib/libcursesw.a
ln -sfv libncurses.a       /usr/lib/libcurses.a

cd ..

rm -rf $PKGDIR

cd $PREV_DIR

unset PREV_DIR PKGDIR
echo "./20-ncurses.sh ran"
