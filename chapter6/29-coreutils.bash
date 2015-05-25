#!/tools/bin/bash -e

source try_unpack.bash



export PKGDIR="coreutils-8.23"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

patch -Np1 -i ../coreutils-8.23-i18n-1.patch
touch Makefile.in

FORCE_UNSAFE_CONFIGURE=1 ./configure \
            --prefix=/usr            \
            --enable-no-install-program=kill,uptime
            
make

make install

for file in cat chgrp chmod chown cp date dd df echo false ln ls mkdir mknod mv pwd rm rmdir stty sync true uname
do
	if [ -f /usr/bin/$file ]; then
		mv -v /usr/bin/$file /bin
	fi
done
if [ -f /usr/bin/chroot ]; then
	mv -v /usr/bin/chroot /usr/sbin
fi
if [ -f /usr/share/man/man1/chroot.1 ]; then
	mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
fi

if [ -f /usr/share/man/man8/chroot.8 ]; then
	sed -i s/\"1\"/\"8\"/1 /usr/share/man/man8/chroot.8
fi

for file in {head,sleep,nice,test,[}
do
	if [ -f /usr/bin/$file ]; then
		mv -v /usr/bin/$file /bin
	fi
done
#mv -v /usr/bin/{head,sleep,nice,test,[} /bin
unset file
cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR
echo "./29-coreutils.sh ran"
