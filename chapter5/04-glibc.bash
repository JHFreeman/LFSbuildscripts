#!/bin/bash -e

export PKGNAME="glibc"
export PKGVER="2.21"
export LOGFILE="../glibc.log"

trap 'echo '$PKGNAME'-'$PKGVER'; times' EXIT

export LFS=/mnt/lfs

source try_unpack.bash

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

CFLAGS="-march=native -pipe -O2" \
CXXFLAGS="-march=native -pipe -O2" \
 ../$PKGNAME-$PKGVER/configure                             \
      --prefix=/tools                               \
      --host=$LFS_TGT                               \
      --build=$(../glibc-2.21/scripts/config.guess) \
      --disable-profile                             \
      --enable-kernel=3.4.0	                        \
      --enable-add-ons								\
      --enable-bind-now								\
      --enable-stackguard-randomization				\
      --enable-lock-epsilon							\
      --enable-obsolete-rpc                         \
      --with-headers=/tools/include                 \
      libc_cv_forced_unwind=yes                     \
      libc_cv_ctors_header=yes                      \
      libc_cv_c_cleanup=yes
      
make

make install

echo 'main(){}' > dummy.c
$LFS_TGT-gcc dummy.c
readelf -l a.out > $LOGFILE
readelf -l a.out | grep ': /tools' >> $LOGFILE
rm -v dummy.c a.out

cd ..

rm -rf $PKGNAME-build $PKGNAME-$PKGVER

unset PKGNAME PKGVER LOGFILE

popd