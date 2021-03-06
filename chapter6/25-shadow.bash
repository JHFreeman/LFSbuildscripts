#!/tools/bin/bash -e

source try_unpack.bash

export PKGDIR="shadow-4.2.1"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

sed -i 's/groups$(EXEEXT) //' src/Makefile.in
find man -name Makefile.in -exec sed -i 's/groups\.1 / /' {} \;

sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@' \
       -e 's@/var/spool/mail@/var/mail@' etc/login.defs
       
sed -i 's/1000/999/' etc/useradd

CFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
./configure --sysconfdir=/etc --with-group-name-max-length=32

make

make install

mv -v /usr/bin/passwd /bin


pwconv

grpconv

sed -i 's/yes/no/' /etc/default/useradd

cd ..

rm -rf $PKGDIR

popd

unset  PKGDIR
