#!/bin/bash -e

source try_unpack.bash



export PKGDIR="kmod-20"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr          \
            --bindir=/bin          \
            --sysconfdir=/etc      \
            --with-rootlibdir=/lib \
            --with-xz              \
            --with-zlib
            
make

make install

for target in depmod insmod lsmod modinfo modprobe rmmod; do
  ln -sv ../bin/kmod /sbin/$target
done

ln -sv kmod /bin/lsmod

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
echo "./59-kmod.sh ran"
