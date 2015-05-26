#!/tools/bin/bash -e

source try_unpack.bash



export PKGDIR="procps-ng-3.3.10"

pushd /sources

try_unpack $PKGDIR

cd $PKGDIR

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
rm -rf $PKGDIR
popd
unset  PKGDIR
echo "./27-procps-ng.sh ran"
