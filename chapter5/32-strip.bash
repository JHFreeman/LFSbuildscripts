#!/bin/bash -e

LFS=/mnt/lfs
trap 'echo strip; times' EXIT
strip --strip-debug /tools/lib/*

/usr/bin/strip --strip-unneeded /tools/{,s}bin/*

rm -rf /tools/{,share}/{info,man,doc}

chown -R root:root $LFS/tools
