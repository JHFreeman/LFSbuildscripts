#!/bin/bash -e

source try_unpack.bash



pushd /sources

tar -xf blfs-systemd-units-20150210.tar.bz2



popd

unset PKGDIR

logout