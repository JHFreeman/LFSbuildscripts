#!/bin/bash

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="grub-2.02~beta2"

cd /sources

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
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./54-grub.sh ran"
