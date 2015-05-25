#!/bin/bash

source get_dir.sh
export URL="http://linux-pam.org/library/Linux-PAM-1.1.8.tar.bz2"
export FILE=${URL##*/}

pushd /sources

if [ -e $FILE ]; then
	rm -rf $FILE
fi

wget $URL

export PKGDIR=$(get_dir ${FILE})

tar -xf ${FILE}

cd $PKDIR

