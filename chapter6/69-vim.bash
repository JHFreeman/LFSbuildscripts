#!/bin/bash

source try_unpack.bash

export PKGDIR="vim74"
export PKGFILE="vim-7.4"

trap 'echo '$PKGDIR'; times' EXIT

pushd /sources

try_unpack $PKGFILE

cd $PKGDIR

echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h

CFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong" \
./configure --prefix=/usr

make
make install

if [ -h /usr/bin/vi ]; then
	rm -rf /usr/bin/vi
fi
ln -sv vim /usr/bin/vi
for L in  /usr/share/man/{,*/}man1/vim.1; do
	if [ -h $(dirname $L)/vi.1 ]; then
		rm -rf $(dirname $L)/vi.1
	fi
    ln -sv vim.1 $(dirname $L)/vi.1
done

if [ -h /usr/share/doc/vim-7.4 ]; then
	rm -rf /usr/share/doc/vim-7.4
fi
ln -sv ../vim/vim74/doc /usr/share/doc/vim-7.4
if [ ! -e /etc/vimrc ]; then
cat > /etc/vimrc << "EOF"
" Begin /etc/vimrc

set nocompatible
set backspace=2
syntax on
if (&term == "iterm") || (&term == "putty")
  set background=dark
endif

" End /etc/vimrc
EOF
fi
cp /etc/vimrc /etc/skel/.vimrc

cd ..
rm -rf $PKGDIR
popd
unset  PKGDIR PKGFILE
