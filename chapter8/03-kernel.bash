#!/bin/bash -e

export CFLAGS="-march=native -pipe -O2 -mavx -fstack-protector-strong"
export CXXFLAGS="-march=native -pipe -O2 -mavx -fstack-protector-strong"

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source try_unpack.bash

PKGVER="4.0.3"
PKGDIR="linux-$PKGVER"


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

cp arch/x86/boot/bzImage /boot/vmlinuz-$PKGVER-lfs-developmental-systemd

cp -v System.map /boot/System.map-$PKGVER

cp -v .config /boot/config-$PKGVER

install -d /usr/share/doc/linux-$PKGVER

cp -r Documentation/* /usr/share/doc/linux-$PKGVER

chown -R 0:0 /etc/src/$PKGDIR

popd

unset CFLAGS CXXFLAGS
