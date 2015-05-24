#!/tools/bin/bash -e

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="bash-4.3.30"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

patch -Np1 -i ../bash-4.3.30-upstream_fixes-1.patch

./configure --prefix=/usr                       \
            --bindir=/bin                       \
            --docdir=/usr/share/doc/bash-4.3.30 \
            --without-bash-malloc               \
            --with-installed-readline
            
make

make install

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR

exec /bin/bash --login +h
echo "./36-bash.sh ran"
