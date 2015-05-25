#!/bin/bash -e

source try_unpack.sh
source get_dir.sh
export URL="http://downloads.sourceforge.net/tcl/tcl8.6.3-src.tar.gz"
export FILE=${URL##*/}

pushd /sources

if [ -e $FILE ]; then
	rm -rf $FILE
fi

wget $URL

export PKGDIR=$(get_dir ${FILE})

if [ -d $PKGDIR ]; then
	rm -rf $PKGDIR
fi

tar -xf ${FILE}

cd $PKGDIR/unix

rm -rf ../pkgs/sqlite*

export SRCDIR=`pwd` &&

./configure --prefix=/usr           \
            --without-tzdata        \
            --mandir=/usr/share/man \
            $([ $(uname -m) = x86_64 ] && echo --enable-64bit) &&
make &&

sed -e "s#$SRCDIR/unix#/usr/lib#" \
    -e "s#$SRCDIR#/usr/include#"  \
    -i tclConfig.sh               &&

sed -e "s#$SRCDIR/unix/pkgs/tdbc1.0.2#/usr/lib/tdbc1.0.2#" \
    -e "s#$SRCDIR/pkgs/tdbc1.0.2/generic#/usr/include#"    \
    -e "s#$SRCDIR/pkgs/tdbc1.0.2/library#/usr/lib/tcl8.6#" \
    -e "s#$SRCDIR/pkgs/tdbc1.0.2#/usr/include#"            \
    -i pkgs/tdbc1.0.2/tdbcConfig.sh                        &&

sed -e "s#$SRCDIR/unix/pkgs/itcl4.0.2#/usr/lib/itcl4.0.2#" \
    -e "s#$SRCDIR/pkgs/itcl4.0.2/generic#/usr/include#"    \
    -e "s#$SRCDIR/pkgs/itcl4.0.2#/usr/include#"            \
    -i pkgs/itcl4.0.2/itclConfig.sh                        &&

unset SRCDIR

make install &&
make install-private-headers &&
ln -sfv tclsh8.6 /usr/bin/tclsh &&
chmod -v 755 /usr/lib/libtcl8.6.so
cd ../..
rm -rf $PKGDIR $FILE
unset URL PKGDIR FILE
popd