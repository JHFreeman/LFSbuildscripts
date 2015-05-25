#!/bin/bash -e

source ../get_dir.sh
export URL="http://ftp.gnu.org/non-gnu/cvs/source/stable/1.11.23/cvs-1.11.23.tar.bz2"
PATCH="http://www.linuxfromscratch.org/patches/blfs/systemd/cvs-1.11.23-zlib-1.patch"
export FILE=${URL##*/}

pushd /sources

if [ -e $FILE ]; then
	rm $FILE
fi

wget $URL
wget $PATCH

export PKGDIR=$(get_dir ${FILE})

if [ -d $PKGDIR ]; then
	rm -rf $PKGDIR
fi

tar -xf ${FILE}

cd $PKGDIR

patch -Np1 -i ../${PATCH##*/}

sed -i -e 's/getline /get_line /' lib/getline.{c,h} &&
sed -i -e 's/^@sp$/& 1/'          doc/cvs.texinfo &&
touch doc/*.pdf

./configure --prefix=/usr --docdir=/usr/share/doc/cvs-1.11.23 &&
make

make install &&
make -C doc install-pdf &&
install -v -m644 FAQ README /usr/share/doc/cvs-1.11.23

cd ..

rm -rf $PKGDIR

rm $FILE

rm ${PATCH##*/}

popd

unset URL PATCH PKGDIR FILE