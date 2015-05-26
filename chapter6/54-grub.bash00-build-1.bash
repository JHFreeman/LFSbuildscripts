#!/bin/bash -e

source try_unpack.bash



export PKGDIR="grub-2.02~beta2"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr          \
            --sbindir=/sbin        \
            --sysconfdir=/etc      \
            --disable-grub-emu-usb \
            --disable-efiemu       \
            --disable-werror
            
make

make install

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
echo "./54-grub.sh ran"
source 55-less.sh
