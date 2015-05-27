#!/bin/bash -e

export DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source try_unpack.bash

export PKGDIR="linux-3.19"

pushd /sources

try_unpack $PKGDIR

if [ ! -d /etc/src ]; then
	mkdir -pv /etc/src
fi

if [ -d /etc/src/$PKGDIR ]; then
	rm -rf /etc/src/$PKGDIR
fi

mv $PKGDIR /etc/src/$PKGDIR

popd

pushd /etc/src/$PKGDIR

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

chown -R 0:0 /etc/src/$PKGDIR

popd

./4-grub.sh
