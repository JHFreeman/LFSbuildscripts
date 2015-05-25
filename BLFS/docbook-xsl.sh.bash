#!/bin/bash

source get_dir.sh
export URL="http://downloads.sourceforge.net/docbook/docbook-xsl-1.78.1.tar.bz2"
export FILE=${URL##*/}

pushd /sources

if [ -e $FILE ]; then
	rm $FILE
fi

wget $URL

export PKGDIR=$(get_dir ${FILE})

if [ -d $PKGDIR ]; then
	rm -rf $PKGDIR
fi

tar -xf ${FILE}

cd $PKGDIR

install -v -m755 -d /usr/share/xml/docbook/xsl-stylesheets-1.78.1 &&

cp -v -R VERSION common eclipse epub extensions fo highlighting html \
         htmlhelp images javahelp lib manpages params profiling \
         roundtrip slides template tests tools webhelp website \
         xhtml xhtml-1_1 \
    /usr/share/xml/docbook/xsl-stylesheets-1.78.1 &&

if [ ! -h /usr/share/xml/docbook/xsl-stylesheets-1.78.1/VERSION.xsl ]; then
	ln -s VERSION /usr/share/xml/docbook/xsl-stylesheets-1.78.1/VERSION.xsl
fi

install -v -m644 -D README \
                    /usr/share/doc/docbook-xsl-1.78.1/README.txt &&
install -v -m644    RELEASE-NOTES* NEWS* \
                    /usr/share/doc/docbook-xsl-1.78.1
                    
                    if [ ! -d /etc/xml ]; then install -v -m755 -d /etc/xml; fi &&
if [ ! -f /etc/xml/catalog ]; then
    xmlcatalog --noout --create /etc/xml/catalog
fi &&

xmlcatalog --noout --add "rewriteSystem" \
           "http://docbook.sourceforge.net/release/xsl/1.78.1" \
           "/usr/share/xml/docbook/xsl-stylesheets-1.78.1" \
    /etc/xml/catalog &&

xmlcatalog --noout --add "rewriteURI" \
           "http://docbook.sourceforge.net/release/xsl/1.78.1" \
           "/usr/share/xml/docbook/xsl-stylesheets-1.78.1" \
    /etc/xml/catalog &&

xmlcatalog --noout --add "rewriteSystem" \
           "http://docbook.sourceforge.net/release/xsl/current" \
           "/usr/share/xml/docbook/xsl-stylesheets-1.78.1" \
    /etc/xml/catalog &&

xmlcatalog --noout --add "rewriteURI" \
           "http://docbook.sourceforge.net/release/xsl/current" \
           "/usr/share/xml/docbook/xsl-stylesheets-1.78.1" \
    /etc/xml/catalog
    
    
cd ..

rm -rf $PKGDIR

rm $FILE

unset FILE PKGDIR URL