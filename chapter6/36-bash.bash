#!/tools/bin/bash -e

source try_unpack.bash

export PKGDIR="bash-4.3.30"

pushd /sources

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
popd
unset  PKGDIR
exec /bin/bash --login +h /Home/Documents/linuxbuild/chapter6/00-build.bash 4
#source 37-bc.sh

echo "./36-bash.sh ran"
