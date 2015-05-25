#!/bin/bash -e

source get_dir.sh
export URL="http://xmlsoft.org/sources/libxml2-2.9.2.tar.gz"
export FILE=${URL##*/}

pushd /sources

if [ -e $FILE ]; then
	rm $FILE
fi

wget $URL

export PKGDIR=$(get_dir ${FILE})

tar -xf ${FILE}

cd $PKGDIR

sed \
  -e /xmlInitializeCatalog/d \
  -e 's/((ent->checked =.*&&/(((ent->checked == 0) ||\
          ((ent->children == NULL) \&\& (ctxt->options \& XML_PARSE_NOENT))) \&\&/' \
  -i parser.c
  
./configure --prefix=/usr --disable-static --with-history &&
make

make install

cd ..

rm -rf $PKGDIR
rm $FILE

popd

unset FILE PKGDIR URL