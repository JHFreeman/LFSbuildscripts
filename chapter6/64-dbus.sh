#!/bin/bash

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="dbus-1.8.16"

cd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr                       \
            --sysconfdir=/etc                   \
            --localstatedir=/var                \
            --docdir=/usr/share/doc/dbus-1.8.16 \
            --with-console-auth-dir=/run/console
            
make

make install

mv -v /usr/lib/libdbus-1.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libdbus-1.so) /usr/lib/libdbus-1.so

ln -sfv /etc/machine-id /var/lib/dbus

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR
echo "./64-dbus.sh ran"
