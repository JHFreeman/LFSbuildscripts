#!/bin/bash -e

export LOGFILENAME="1-script1.sh.log"
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
PREV_DIR=$PWD
source $DIR/as_root.bash

export LFS=/mnt/lfs

if [ ! -e /etc/sudoers.d/90-lfs ]; then
	as_root echo "lfs ALL=(ALL) NOPASSWD: ALL" > ./90-lfs
	as_root cp ./90-lfs /etc/sudoers.d/
fi

pushd $DIR/preface/
./vii-requirements
popd

pushd $DIR/chapter2
./02-creating-partitions
popd