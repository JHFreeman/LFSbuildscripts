#!/bin/bash

export LFS=/mnt/lfs

try_unpack()
{
	if [ -f $1.tar.xz ]; then
		tar -xf $1.tar.xz
	elif [ -f $1.tar.gz ]; then
		tar -xf $1.tar.gz
	elif [ -f $1.tgz ]; then
		tar -xf $1.tgz
	elif [ -f $1.tar.bz2 ]; then
		tar -xf $1.tar.bz2
	else
		return 1
	fi
}

export -f try_unpack

try_unpack linux-3.19

cd linux-3.19

make mrproper

make INSTALL_HDR_PATH=dest headers_install
find dest/include \( -name .install -o -name ..install.cmd \) -delete
cp -rv dest/include/* /usr/include

cd ..
rm -rf linux-3.19

try_unpack man-pages-3.79

cd man-pages-3.79

make install

cd ..

rm -rf man-pages-3.79

try_unpack glibc-2.21

cd glibc-2.21

patch -Np1 -i ../glibc-2.21-fhs-1.patch

sed -e '/ia32/s/^/1:/' \
	-e '/SSE2/s/^1://' \
	-i sysdeps/i386/i686/multiarch/mempcpy_chk.S
	
mkdir -v ../glibc-build
cd ../glibc-build

../glibc-2.21/configure    \
    --prefix=/usr          \
    --disable-profile      \
    --enable-kernel=2.6.32 \
    --enable-obsolete-rpc
    
make

touch /etc/ld.so.conf

make install

cp -v ../glibc-2.21/nscd/nscd.conf /etc/nscd.conf
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
zic -d $ZONEINFO -p America/New_York
unset ZONEINFO

ln -sfv /usr/share/zoneinfo/America/Chicago /etc/localtime

cat > /etc/ld.so.conf << "EOF"
# Begin /etc/ld.so.conf
/usr/local/lib
/opt/lib

EOF

cd ..

rm -rf glibc-build glibc-2.21

mv -v /tools/bin/{ld,ld-old}
mv -v /tools/$(gcc -dumpmachine)/bin/{ld,ld-old}
mv -v /tools/bin/{ld-new,ld}
ln -sv /tools/bin/ld /tools/$(gcc -dumpmachine)/bin/ld

gcc -dumpscpecs | sed -e 's@/tools@@g' \
	-e '/\*startfile_prefix_spec:/{n;s@.*@/usr/lib/ @}' \
	-e '/\*cpp:/{n;s@$@ -isystem /usr/include@}' \
	`dirname $(gcc --print-libgcc-file-name)`/specs
	
try_unpack zlib-1.2.8

cd zlib-1.2.8

./configure --prefix=/usr

make

make install

mv -v /usr/lib/libz.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libz.so) /usr/lib/libz.so

cd ..
rm -rf zlib-1.2.8

try_unpack file-5.2.2

cd file-5.2.2
./configure --prefix=/usr

make

make install

cd ..
rm -rf file-5.2.2

try_unpack binutils-2.25

mkdir binutils-build
cd binutils-build
../binutils-2.25/configure --prefix=/usr \
							--enable-shared \
							--disable-werror
							
make tooldir=/usr

make tooldir=/usr install

cd ..
rm -rf binutils-build binutils-2.25

try_unpack gmp-6.0.0a

cd gmp-6.0.0

./configure --prefix=/usr \
	--enable-cxx \
	--docdir=/usr/share/doc/gmp-6.0.0a
	
make
make html

make install
make install-html

cd ..
rm -rf gmp-6.0.0

try_unpack mpfr-3.1.2

cd mpfr-3.1.2

patch -Np1 -i ../mpfr-3.1.2-upstream_fixes-3.patch

./configure --prefix=/usr \
	--enable-thread-safe \
	--docdir=/usr/share/doc/mpfr-3.1.2
	
make
make html

make install
make install-html

cd ..
rm -rf mpfr-3.1.2

try_unpack mpc-1.0.2

cd mpc-1.0.2

./configure --prefix=/usr --docdir=/usr/share/doc/mpc-1.0.2
make
make html

make install
make install-html

cd ..
rm -rf mpc-1.0.2

try_unpack gcc-4.9.2

mkdir gcc-build
cd gcc-build

SED=sed \
../gcc-4.9.2/configure \
	--prefix=/usr \
	--enable-languages=c,c++ \
	--disable-multilib \
	--disable-bootstrap \
	--with-system-zlib
	
make

make install

ln -sv ../usr/bin/cpp /lib

ln -sv gcc /usr/bin/cc

nstall -v -dm755 /usr/lib/bfd-plugins
ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/4.9.2/liblto_plugin.so /usr/lib/bfd-plugins/

mkdir -pv /usr/share/gdb/auto-load/usr/lib
mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib

cd ..
rm -rf gcc-build gcc-4.9.2

try_unpack bzip2-1.0.6

cd bzip2-1.0.6

patch -Np1 -i ../bzip2-1.0.6-install_docs-1.patch

sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile
sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile

make -F Makefile-libbz2_so
make clean

make

make PREFIX=/usr install

cp -v bzip2-shared /bin/bzip2
cp -av libbz2.so* /lib
ln -sv ../../lib/libbz2.so.1.0 /usr/lib/libbz2.so
rm -v /usr/bin/{bunzip2,bzcat,bzip2}
ln -sv bzip2 /bin/bunzip2
ln -sv bzip2 /bin/bzcat

cd ..
rm -rf bzip2-1.0.6

try_unpack pkg-config-0.28

cd pkg-config-0.28

./configure --prefix=/usr \
	--with-internal-glib \
	--disable-host-tool \
	--docdir=/usr/share/doc/pkg-config-0.28
	
make

make install

cd ..
rm -rf pkg-config-0.28

try_unpack ncurses-5.9

cd ncurses-5.9

./configure --prefix=/usr           \
            --mandir=/usr/share/man \
            --with-shared           \
            --without-debug         \
            --enable-pc-files       \
            --enable-widec
            
make

mv -v /usr/lib/libncursesw.so.5* /lib

ln -sfv ../../lib/$(readlink /usr/lib/libncursesw.so) /usr/lib/libncursesw.so

for lib in ncurses form panel menu ; do
    rm -vf                    /usr/lib/lib${lib}.so
    echo "INPUT(-l${lib}w)" > /usr/lib/lib${lib}.so
    ln -sfv lib${lib}w.a      /usr/lib/lib${lib}.a
    ln -sfv ${lib}w.pc        /usr/lib/pkgconfig/${lib}.pc
done

ln -sfv libncurses++w.a /usr/lib/libncurses++.a

rm -vf                     /usr/lib/libcursesw.so
echo "INPUT(-lncursesw)" > /usr/lib/libcursesw.so
ln -sfv libncurses.so      /usr/lib/libcurses.so
ln -sfv libncursesw.a      /usr/lib/libcursesw.a
ln -sfv libncurses.a       /usr/lib/libcurses.a

mkdir -v       /usr/share/doc/ncurses-5.9
cp -v -R doc/* /usr/share/doc/ncurses-5.9

cd ..
rm -rf ncurses-5.9

try_unpack attr-2.4.47

cd attr-2.4.47

sed -i -e 's|/@pkg_name@|&-@pkg_version@|' include/builddefs.in

sed -i -e "/SUBDIRS/s|man2||" man/Makefile

./configure --prefix=/usr

make

make install install-dev install-lib
chmod -v 755 /usr/lib/libattr.so

mv -v /usr/lib/libattr.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libattr.so) /usr/lib/libattr.so

cd ..
rm -rf attr-2.4.47

try_unpack acl-2.2.52

cd acl-2.2.52

sed -i -e 's|/@pkg_name@|&-@pkg_version@|' include/builddefs.in

sed -i "s:| sed.*::g" test/{sbits-restore,cp,misc}.test

sed -i -e "/TABS-1;/a if (x > (TABS-1)) x = (TABS-1);" \
    libacl/__acl_to_any_text.c
    
./configure --prefix=/usr --libexecdir=/usr/lib

make

make install install-dev install-lib
chmod -v 755 /usr/lib/libacl.so

mv -v /usr/lib/libacl.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libacl.so) /usr/lib/libacl.so

cd ..
rm -rf acl-2.2.52

try_unpack libcap-2.24

cd libcap-2.24

make

make RAISE_SETFCAP=no prefix=/usr install
chmod -v 755 /usr/lib/libcap.so

mv -v /usr/lib/libcap.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libcap.so) /usr/lib/libcap.so

cd ..
rm -rf libcap-2.24

try_unpack sed-4.2.2
cd 4.2.2

./configure --prefix=/usr --bindir=/bin --htmldir=/usr/share/doc/sed-4.2.2

make
make html

make install
make -C doc install-html

cd ..
rm -rf sed-4.2.2

try_unpack shadow-4.2.1
cd shadow-4.2.1

sed -i 's/groups$(EXEEXT) //' src/Makefile.in
find man -name Makefile.in -exec sed -i 's/groups\.1 / /' {} \;

sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@' \
       -e 's@/var/spool/mail@/var/mail@' etc/login.defs
       
sed -i 's/1000/999/' etc/useradd

./configure --sysconfdir=/etc --with-group-name-max-length=32

make

make install

mv -v /usr/bin/passwd /bin

pwconv
grpconv

sed -i 's/yes/no/' /etc/default/useradd

cd ..
rm -rf sed-4.2.2

try_unpack psmisc-22.21
cd psmisc-22.21
./configure --prefix=/usr

make

make install

mv -v /usr/bin/{fuser,killall} /bin

cd ..
rm -rf psmisc-22.21

try_unpack procps-ng-3.3.10
cd procps-ng-3.3.10

./configure --prefix=/usr                            \
            --exec-prefix=                           \
            --libdir=/usr/lib                        \
            --docdir=/usr/share/doc/procps-ng-3.3.10 \
            --disable-static                         \
            --disable-kill
            
make

make install

mv -v /usr/bin/pidof /bin
mv -v /usr/lib/libprocps.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libprocps.so) /usr/lib/libprocps.so

cd ..
rm -rf procps-ng-3.3.10

try_unpack e2fsprogs-1.42.12
cd e2fsprogs-1.42.12

sed -e '/int.*old_desc_blocks/s/int/blk64_t/' \
    -e '/if (old_desc_blocks/s/super->s_first_meta_bg/desc_blocks/' \
    -i lib/ext2fs/closefs.c
    
mkdir -v build
cd build

LIBS=-L/tools/lib                    \
CFLAGS=-I/tools/include              \
PKG_CONFIG_PATH=/tools/lib/pkgconfig \
../configure --prefix=/usr           \
             --bindir=/bin           \
             --with-root-prefix=""   \
             --enable-elf-shlibs     \
             --disable-libblkid      \
             --disable-libuuid       \
             --disable-uuidd         \
             --disable-fsck
             
make

make install

make install-libs

chmod -v u+w /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a

gunzip -v /usr/share/info/libext2fs.info.gz
install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info

cd ..
rm -rf e2fsprogs-1.42.12

try_unpack coreutils-8.23
cd coreutils-8.23

patch -Np1 -i ../coreutils-8.23-i18n-1.patch
touch Makefile.in

FORCE_UNSAFE_CONFIGURE=1 ./configure \
            --prefix=/usr            \
            --enable-no-install-program=kill,uptime
            
make

make install

mv -v /usr/bin/{cat,chgrp,chmod,chown,cp,date,dd,df,echo} /bin
mv -v /usr/bin/{false,ln,ls,mkdir,mknod,mv,pwd,rm} /bin
mv -v /usr/bin/{rmdir,stty,sync,true,uname} /bin
mv -v /usr/bin/chroot /usr/sbin
mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
sed -i s/\"1\"/\"8\"/1 /usr/share/man/man8/chroot.8

mv -v /usr/bin/{head,sleep,nice,test[} /bin

cd ..
rm -rf coreutils-8.23

try_unpack iana-etc-2.30
cd iana-etc-2.30
make
make install
cd ..
rm -rf iana-etc-2.30

try_unpack m4-1.4.17
cd m4-1.4.17
./configure --prefix=/usr
make
make install
cd ..
rm -rf m4-1.4.17

try_unpack flex-2.5.39
cd flex-2.5.39
sed -i -e '/test-bison/d' tests/Makefile.in
./configure --prefix=/us --docdir=/usr/share/doc/flex-2.5.39
make
make install
ln -sv flex /usr/bin/lex
cd ..
rm -rf flex-2.5.39

try_unpack bison-3.0.4
cd bison-3.0.4
./configure --prefix=/usr --docdir=/usr/share/doc/bison-3.0.4
make
make install
cd ..
rm -rf bison-3.0.4

try_unpack grep-2.21
cd grep-2.21
sed -i -e '/tp++/a  if (ep <= tp) break;' src/kwset.c
./configure --prefix=/usr --bindir=/bin
make
make install
cd ..
rm -rf grep-2.21

try_unpack readline-6.3
cd readline-6.3
patch -Np1 -i ../readline-6.3-upstream_fixes-3.patch

sed -i 'MV.*old/d' Makefile.in
sed -i '/{OLDSTUFF}/c:' support/shlib-install
./configure --prefix=/usr --docdir=/usr/share/doc/readline-6.3
make SHLIB_LIBS=-lncurses
make SHLIB_LIBS=-lncurses install
mv -v /usr/lib/lib{readline,history}.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libreadline.so) /usr/lib/libreadline.so
ln -sfv ../../lib/$(readlink /usr/lib/libhistory.so ) /usr/lib/libhistory.so
cd ..
rm -rf readline-6.3

try_unpack bash-4.3.30
cd bash-4.3.30
patch -Np1 -i ../bash-4.3.30-upstream_fixes-1.patch
./configure --prefix=/usr                       \
            --bindir=/bin                       \
            --docdir=/usr/share/doc/bash-4.3.30 \
            --without-bash-malloc               \
            --with-installed-readline
make
make install
exec /bin/bash --login +h
cd ..
rm -rf bash-4.3.30

try_unpack bc-1.06.95
cd bc-1.06.95
patch -Np1 -i ../bc-1.06.95-memory_leak-1.patch
./configure --prefix=/usr           \
            --with-readline         \
            --mandir=/usr/share/man \
            --infodir=/usr/share/info
make
make install
cd ..
rm -rf bc-1.06.95

try_unpack libtool-2.4.6
cd libtool-2.4.6
./configure --prefix=/usr
make
make install
cd ..
rm -rf libtool-2.4.6

try_unpack gdbm-1.11
cd gdbm-1.11
./configure --prefix=/usr --enable-libgdbm-compat
make
make install
cd ..
rm -rf gdbm-1.11

try_unpack expat-2.1.0
cd expat-2.1.0
./configure --prefix=/usr
make
make install
cd ..
rm -rf expat-2.1.0

try_unpack inetutils-1.9.2
cd inetutils-1.9.2
echo '#define PATH_PROCNET_DEV "/proc/net/dev"' >> ifconfig/system/linux.h 
./configure --prefix=/usr        \
            --localstatedir=/var \
            --disable-logger     \
            --disable-whois      \
            --disable-servers
make
make install
mv -v /usr/bin/{hostname,ping,ping6,traceroute} /bin
mv -v /usr/bin/ifconfig /sbin
cd ..
rm -rf inetutils-1.9.2

try_unpack perl-5.20.2
cd perl-5.20.2
echo "127.0.0.1 localhost $(hostname)" > /etc/hosts
export BUILD_ZLIB=False
export BUILD_BZIP2=0
sh Configure -des -Dprefix=/usr                 \
                  -Dvendorprefix=/usr           \
                  -Dman1dir=/usr/share/man/man1 \
                  -Dman3dir=/usr/share/man/man3 \
                  -Dpager="/usr/bin/less -isR"  \
                  -Duseshrplib
make
make install
unset BUILD_ZLIB BUILD_BZIP2
cd ..
rm -rf perl-5.20.2

try_unpack XML-Parser-2.44
cd XML-Parser-2.44
perl Makefile.PL
make
make install
cd ..
rm -rf XML-Parse-2.44

try_unpack autoconf-2.69
cd autoconf-2.69
./configure --prefix=/usr
make
make install
cd ..
rm -rf autoconf-2.69

try_unpack automake-1.15
cd automake-1.15
./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.15
make
make install
cd ..
rm -rf automake-1.15

try_unpack diffutils-3.3
cd diffutils-3.3
sed -i 's:= @mkdir_p@:= /bin/mkdir -p:' po/Makefile.in.in
./configure --prefix=/usr
make
make install
cd ..
rm -rf diffutils-3.3

try_unpack gawk-4.1.1
cd gawk-4.1.1
./configure --prefix=/usr
make
make install
cd ..
rm -rf gawk-4.1.1

try_unpack findutils-4.4.2
cd findutils-4.4.2
./configure --prefix=/usr --localstatedir=/var/lib/locate
make
make install
mv -v /usr/bin/find /bin
sed -i 's|find:=${BINDIR}|find:=/bin|' /usr/bin/updatedb
cd ..
rm -rf findutils-4.4.2

try_unpack gettext-0.19.4
cd gettext-0.19.4
./configure --prefix=/usr --docdir=/usr/share/doc/gettext-0.19.4
make
make install
cd ..
rm -rf gettext-0.19.4

try_unpack intltool-0.50.2
cd intltool-0.50.2
./configure --prefix=/usr
make
make install
install -v -Dm doc/I18N-HOWTO /usr/share/doc/intltool-0.50.2/I18N-HOWTO
cd ..
rm -rf intltool-0.50.2

try_unpack gperf-3.0.4
cd gperf-3.0.4
./configure --prefix=/usr --docdir=/usr/share/doc/gperf-3.0.4
make
make install
cd ..
rm -rf gperf-3.0.4

try_unpack groff-1.22.3
cd groff-1.22.3
PAGE=letter ./configure --prefix=/usr
make
make install
cd ..
rm -rf groff-1.22.3

try_unpack xz-5.2.0
cd xz-5.2.0
./configure --prefix=/usr --docdir=/usr/share/doc/xz-5.2.0
make
make install
mv -v   /usr/bin/{lzma,unlzma,lzcat,xz,unxz,xzcat} /bin
mv -v /usr/lib/liblzma.so.* /lib
ln -svf ../../lib/$(readlink /usr/lib/liblzma.so) /usr/lib/liblzma.so
cd ..
rm -rf xz-5.2.0

try_unpack grub-2.02~beta2
cd grub-2.02~beta2
./configure --prefix=/usr          \
            --sbindir=/sbin        \
            --sysconfdir=/etc      \
            --disable-grub-emu-usb \
            --disable-efiemu       \
            --disable-werror
make
make install
cd ..
rm -rf grub-2.02~beta2

try_unpack less-458
cd less-458
./configure --prefix=/usr --sysconfdir=/etc
make
make install
cd ..
rm -rf less-458

try_unpack gzip-1.6
cd gzip-1.6
./configure --prefix=/usr --bindir=/bin
make
make install
mv -v /bin/{gzexe,uncompress,zcmp,zdiff,zegrep} /usr/bin
mv -v /bin/{zfgrep,zforce,zgrep,zless,zmore,znew} /usr/bin
cd ..
rm -rf gzip-1.6

try_unpack iproute2-3.19.0
cd iproute2-3.19.0
sed -i '/^TARGETS/s@arpd@@g' misc/Makefile
sed -i /ARPD/d Makefile
sed -i 's/arpd.8//' man/man8/Makefile
make
make DOCDIR=/usr/share/doc/iproute2-3.19.0 install
cd ..
rm -rf iproute2-3.19.0

try_unpack kbd-2.0.2
cd kbd-2.0.2
patch -Np1 -i ../kbd-2.0.2-backspace-1.patch
sed -i 's/\(RESIZECONS_PROGS=\)yes/\1no/g' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in
PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr --disable-vlock
make
make install
cd ..
rm -rf kbd-2.0.2

try_unpack kmod-19
cd kmod-19
./configure --prefix=/usr          \
            --bindir=/bin          \
            --sysconfdir=/etc      \
            --with-rootlibdir=/lib \
            --with-xz              \
            --with-zlib
make
make install
for target in depmod insmod lsmod modinfo modprobe rmmod; do
  ln -sv ../bin/kmod /sbin/$target
done

ln -sv kmod /bin/lsmod
cd ..
rm -rf kmod-19

try_unpack libpipeline-1.4.0
cd libpipeline-1.4.0
PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr
make
make install
cd ..
rm -rf libpipeline-1.4.0

try_unpack make-4.1
cd make-4.1
./configure --prefix=/usr
make
make install
cd ..
rm -rf make-4.1

try_unpack patch-2.7.4
cd patch-2.7.4
./configure --prefix=/usr
make
make install
cd ..
rm -rf patch-2.7.4

try_unpack systemd-219
cd systemd-219

cat > config.cache << "EOF"
KILL=/bin/kill
HAVE_BLKID=1
BLKID_LIBS="-lblkid"
BLKID_CFLAGS="-I/tools/include/blkid"
HAVE_LIBMOUNT=1
MOUNT_LIBS="-lmount"
MOUNT_CFLAGS="-I/tools/include/libmount"
cc_cv_CFLAGS__flto=no
EOF

sed -i "s:blkid/::" $(grep -rl "blkid/blkid.h")
patch -Np1 -i ../systemd-219-compat-1.patch
sed -i "s:test/udev-test.pl ::g" Makefile.in

./configure --prefix=/usr                                           \
            --sysconfdir=/etc                                       \
            --localstatedir=/var                                    \
            --config-cache                                          \
            --with-rootprefix=                                      \
            --with-rootlibdir=/lib                                  \
            --enable-split-usr                                      \
            --disable-gudev                                         \
            --disable-firstboot                                     \
            --disable-ldconfig                                      \
            --disable-sysusers                                      \
            --without-python                                        \
            --docdir=/usr/share/doc/systemd-219                     \
            --with-dbuspolicydir=/etc/dbus-1/system.d               \
            --with-dbussessionservicedir=/usr/share/dbus-1/services \
            --with-dbussystemservicedir=/usr/share/dbus-1/system-services
make LIBRARY_PATH=/tools/lib
make LD_LIBRARY_PATH=/tools/lib install
mv -v /usr/lib/libnss_{myhostname,mymachines,resolve}.so.2 /lib
rm -rfv /usr/lib/rpm
for tool in runlevel reboot shutdown poweroff halt telinit; do
     ln -sfv ../bin/systemctl /sbin/${tool}
done
ln -sfv ../lib/systemd/systemd /sbin/init
sed -i "s:0775 root lock:0755 root root:g" /usr/lib/tmpfiles.d/legacy.conf
sed -i "/pam.d/d" /usr/lib/tmpfiles.d/etc.conf
systemd-machine-id-setup
cd ..
rm -rf systemd-219

try_unpack dbus-1.8.16
cd dbus-1.8.16
./configure --prefix=/usr                       \
            --sysconfdir=/etc                   \
            --localstatedir=/var                \
            --docdir=/usr/share/doc/dbus-1.8.16 \
            --with-console-auth-dir=/run/console
make
make install
mv -v /usr/lib/libdbus-1.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libdbus-1.so) /usr/lib/libdbus-1.so
ln -sfv /etc/machine-id /var/lib/dbus
cd ..
rm -rf dbus-1.8.16

try_unpack util-linux-2.26
cd util-linux-2.26
mkdir -pv /var/lib/hwclock
./configure ADJTIME_PATH=/var/lib/hwclock/adjtime   \
            --docdir=/usr/share/doc/util-linux-2.26 \
            --disable-chfn-chsh  \
            --disable-login      \
            --disable-nologin    \
            --disable-su         \
            --disable-setpriv    \
            --disable-runuser    \
            --disable-pylibmount \
            --without-python
make
make install
cd ..
rm -rf util-linux-2.26

try_unpack man-db-2.7.1
cd man-db-2.7.1
./configure --prefix=/usr                        \
            --docdir=/usr/share/doc/man-db-2.7.1 \
            --sysconfdir=/etc                    \
            --disable-setuid                     \
            --with-browser=/usr/bin/lynx         \
            --with-vgrind=/usr/bin/vgrind        \
            --with-grap=/usr/bin/grap
make
make install
sed -i "s:man root:root root:g" /usr/lib/tmpfiles.d/man-db.conf
cd ..
rm -rf man-db-2.7.1

try_unpack tar-1.28
cd tar 1.28
FORCE_UNSAFE_CONFIGURE=1  \
./configure --prefix=/usr \
            --bindir=/bin
make
make install
make -C doc install-html docdir=/usr/share/doc/tar-1.28
cd ..
rm -rf tar-1.28

try_unpack texinfo-5.2
cd texinfo-5.2
./configure --prefix=/usr
make
make install
pushd /usr/share/info
rm -v dir
for f in *
  do install-info $f dir 2>/dev/null
done
popd
cd ..
rm -rf texinfo-5.2

try_unpack vim-7.4
cd vim74
echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
./configure --prefix=/usr
make
make install
ln -sv vim /usr/bin/vi
for L in  /usr/share/man/{,*/}man1/vim.1; do
    ln -sv vim.1 $(dirname $L)/vi.1
done
ln -sv ../vim/vim74/doc /usr/share/doc/vim-7.4
cd ..
rm -rf vim74
