#!/bin/bash -e

source as_root.bash

LFS=/mnt/lfs

if [ ! -d $LFS/Home ]; then
	as_root mkdir -v $LFS/Home
fi

as_root mount -v -t prl_fs Home $LFS/Home

