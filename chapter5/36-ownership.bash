#!/bin/bash -e

LFS=/mnt/lfs

source as_root.bash

as_root chown -R root:root $LFS/tools
