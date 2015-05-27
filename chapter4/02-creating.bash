#!/bin/bash -e

LFS=/mnt/lfs

if [ ! -d $LFS/tools ]; then
	mkdir -v $LFS/tools
fi

if [ ! -h /tools ]; then
	ln -sv $LFS/tools /
fi
