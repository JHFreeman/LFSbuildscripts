#!/bin/bash -e

source try_unpack.bash

export PKGDIR="grub-2.02~beta2"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

unset CFLAGS CXXFLAGS

./configure --prefix=/usr          \
            --sbindir=/sbin        \
            --sysconfdir=/etc      \
            --disable-grub-emu-usb \
            --disable-efiemu       \
            --disable-werror
            
make

make uninstall

make install

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
