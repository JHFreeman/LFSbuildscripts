#!/bin/bash

source try_unpack.sh

export PREV_DIR=$PWD

export PKGDIR="vim74"
export PKGFILE="vim-7.4"

cd /sources

try_unpack $PKGFILE

cd $PKGDIR

echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h

./configure --prefix=/usr

make

make install

ln -sv vim /usr/bin/vi
for L in  /usr/share/man/{,*/}man1/vim.1; do
    ln -sv vim.1 $(dirname $L)/vi.1
done

ln -sv ../vim/vim74/doc /usr/share/doc/vim-7.4


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

cd ..
rm -rf $PKGDIR
cd $PREV_DIR
unset PREV_DIR PKGDIR PKGFILE
echo "./69-vim.sh ran"
