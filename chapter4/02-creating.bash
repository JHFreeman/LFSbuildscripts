#!/bin/bash -e

LFS=/mnt/lfs

source as_root.bash

if [ ! -d $LFS/tools ]; then
	as_root mkdir -v $LFS/tools
fi

if [ ! -h $LFS/tools ]; then
	as_root ln -sv $LFS/tools /
fi

