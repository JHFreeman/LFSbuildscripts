#!/bin/bash -e

source as_root.bash

LFS=/mnt/lfs

#made during installtion

as_root chown -v lfs $LFS/tools

as_root chown -v lfs $LFS/sources

#already in lfs user
