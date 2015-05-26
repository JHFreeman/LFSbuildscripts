#!/bin/bash -e

LFS=/mnt/lfs

source as_root.bash

if [ ! -d $LFS/tools ]; then
	mkdir -v $LFS/tools
fi

if [ ! -h $LFS/tools ]; then
	ln -sv $LFS/tools /
fi
