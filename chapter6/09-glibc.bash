#!/tools/bin/bash -e

source try_unpack.bash

export MAKEFLAGS='-j 3'

export PKGNAME="glibc"
export PKGDIR="glibc-2.21"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

if [ -d $PKGDIR ]; then
	rm -rf $PKGDIR
fi

if [ -d $PKGNAME-build ]; then
	rm -rf $PKGNAME-build
fi

try_unpack $PKGDIR

cd $PKGDIR

patch -Np1 -i ../glibc-2.21-fhs-1.patch

sed -e '/ia32/s/^/1:/' \
	-e '/SSE2/s/^1://' \
	-i sysdeps/i386/i686/multiarch/mempcpy_chk.S
	
sed -i '/glibc.*pad/{i\  buflen = buflen > pad ? buflen - pad : 0;
                     s/ + pad//}' resolv/nss_dns/dns-host.c
	
sed -e '/tst-audit2-ENV/i CFLAGS-tst-audit2.c += -fno-builtin' \
    -i elf/Makefile
	
mkdir ../$PKGNAME-build
cd ../$PKGNAME-build

CFLAGS="-march=native -pipe -O2" \
CXXFLAGS="-march=native -pipe -O2" \
../$PKGDIR/configure    \
    --prefix=/usr          \
    --disable-profile      \
    --enable-kernel=3.4.0 \
    --enable-obsolete-rpc
    
make

 touch /etc/ld.so.conf

 make install

 cp -v ../$PKGDIR/nscd/nscd.conf /etc/nscd.conf
 mkdir -pv /var/cache/nscd

 install -v -Dm644 ../glibc-2.21/nscd/nscd.tmpfiles /usr/lib/tmpfiles.d/nscd.conf
 install -v -Dm644 ../glibc-2.21/nscd/nscd.service /lib/systemd/system/nscd.service

 make localedata/install-locales

cat > /etc/nsswitch.conf << "EOF"
# Begin /etc/nsswitch.conf

passwd: files
group: files
shadow: files

hosts: files dns myhostname
networks: files

protocols: files
services: files
ethers: files
rpc: files

# End /etc/nsswitch.conf
EOF

tar -xf ../tzdata2015a.tar.gz

ZONEINFO=/usr/share/zoneinfo
mkdir -pv $ZONEINFO/{posix,right}

for tz in etcetera southamerica northamerica europe africa antarctica  \
          asia australasia backward pacificnew systemv; do
     zic -L /dev/null   -d $ZONEINFO       -y "sh yearistype.sh" ${tz}
     zic -L /dev/null   -d $ZONEINFO/posix -y "sh yearistype.sh" ${tz}
     zic -L leapseconds -d $ZONEINFO/right -y "sh yearistype.sh" ${tz}
done

 cp -v zone.tab zone1970.tab iso3166.tab $ZONEINFO

 zic -d $ZONEINFO -p America/Chicago
unset ZONEINFO

 ln -sfv /usr/share/zoneinfo/America/Chicago /etc/localtime

cat > /etc/ld.so.conf << "EOF"
# Begin /etc/ld.so.conf
/usr/local/lib
/opt/lib

EOF

cd ..

rm -rf $PKGDIR $PKGNAME-build

popd

unset  PKGDIR PKGNAME
