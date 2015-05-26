#!/bin/bash -e

export PKGNAME="glibc"
export PKGVER="2.21"
export LOGFILE="../glibc.log"

export LFS=/mnt/lfs

source try_unpack.bash

source as_root.bash

pushd $LFS/sources

if [ -d $PKGNAME-$PKGVER ]; then
	rm -rf $PKGNAME-$PKGVER
fi
if [ -d $PKGNAME-build ]; then
	rm -rf $PKGNAME-build
fi

try_unpack $PKGNAME-$PKGVER

cd $PKGNAME-$PKGVER



sed -e '/ia32/s/^/1:/' \
    -e '/SSE2/s/^1://' \
    -i  sysdeps/i386/i686/multiarch/mempcpy_chk.S
	
mkdir ../$PKGNAME-build
cd ../$PKGNAME-build

 ../$PKGNAME-$PKGVER/configure                             \
      --prefix=/tools                               \
      --host=$LFS_TGT                               \
      --build=$(../glibc-2.21/scripts/config.guess) \
      --disable-profile                             \
      --enable-kernel=2.6.32                        \
      --enable-obsolete-rpc                         \
      --with-headers=/tools/include                 \
      libc_cv_forced_unwind=yes                     \
      libc_cv_ctors_header=yes                      \
      libc_cv_c_cleanup=yes
      
make

make install

echo 'main(){}' > dummy.c
$LFS_TGT-gcc dummy.c
readelf -l a.out >> $LOGFILE
readelf -l a.out | grep ': /tools'
rm -v dummy.c a.out

cd ..

rm -rf $PKGNAME-build $PKGNAME-$PKGVER

echo "$PKGNAME-$PKGVER"

unset PKGNAME PKGVER LOGFILE

popd
