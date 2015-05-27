#!/bin/bash -e

source get_dir.bash

pushd /sources

FILE="gpm-1.20.7.tar.bz2"
DIR=$(get_dir ${FILE})

tar -xf ${FILE}

cd $DIR

./autogen.sh                                &&
./configure --prefix=/usr --sysconfdir=/etc &&
make

make install

cd ..

cd get_dir blfs-systemd-units-20150210

make install-gpm

cd ..

rm -rf $DIR

install -v -dm755 /etc/systemd/system/gpm.service.d
echo "ExecStart=/usr/sbin/gpm <list of parameters>" > /etc/systemd/system/gpm.service.d/99-user.conf

popd