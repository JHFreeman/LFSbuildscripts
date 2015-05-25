#!/bin/bash -e

source try_unpack.sh

export PKGDIR="slang-2.2.4"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

./configure --prefix=/usr \
            --sysconfdir=/etc \
            --with-readline=gnu &&
make -j1

make install_doc_dir=/usr/share/doc/slang-2.2.4   \
     SLSH_DOC_DIR=/usr/share/doc/slang-2.2.4/slsh \
     install-all &&

chmod -v 755 /usr/lib/libslang.so.2.2.4 \
             /usr/lib/slang/v2/modules/*.so
             
cd ..

rm -rf $PKGDIR

popd

unset PKGDIR