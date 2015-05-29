#!/tools/bin/bash -e

source try_unpack.bash

export PKGDIR="bash-4.3.30"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

patch -Np1 -i ../bash-4.3.30-upstream_fixes-1.patch

CFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
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
unset  PKGDIR CFLAGS CXXFLAGS
exec /bin/bash --login +h
logout


