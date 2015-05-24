#!/bin/bash -e

export PREV_DIR=$PWD

export DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source try_unpack.sh

export PKGDIR="linux-3.19"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

make mrproper

cp $DIR/config-3.19 ./.config

make oldconfig

make

make modules_install

cp arch/x86/boot/bzImage /boot/vmlinuz-3.19-lfs-7.7-systemd

cp -v System.map /boot/System.map-3.19

cp -v .config /boot/config-3.19

install -d /usr/share/doc/linux-3.19

cp -r Documentation/* /usr/share/doc/linux-3.19

chown -R 0:0 $PWD
