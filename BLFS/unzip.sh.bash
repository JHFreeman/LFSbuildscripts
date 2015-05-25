#!/bin/bash -e

source get_dir.sh
export URL="http://downloads.sourceforge.net/infozip/unzip60.tar.gz"
export FILE=${URL##*/}

pushd /sources

if [ -e $FILE ]; then
	rm $FILE
fi

wget $URL

export PKGDIR=$(get_dir ${FILE})

tar -xf ${FILE}

cd $PKGDIR

case `uname -m` in
  i?86)
    sed -i -e 's/DASM_CRC"/DASM_CRC -DNO_LCHMOD"/' unix/Makefile
    make -f unix/Makefile linux
    ;;
  *)
    sed -i -e 's/CFLAGS="-O -Wall/& -DNO_LCHMOD/' unix/Makefile
    make -f unix/Makefile linux_noasm
    ;;
esac

make prefix=/usr MANDIR=/usr/share/man/man1 install

cd ..

rm -rf $PKGDIR

rm $FILE

popd

unset FILE PKGDIR URL