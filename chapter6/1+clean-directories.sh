#!/bin/bash

source as_root.sh

export LFS=/mnt/lfs

umask 022

as_root rm -rf ${LFS}/{bin,boot,etc/{opt,sysconfig},home,lib/firmware,mnt,opt}
as_root rm -rf ${LFS}/{media/{floppy,cdrom},sbin,srv,var}
as_root rm -rf ${LFS}/root
as_root rm -rf ${LFS}/{,var/}tmp
as_root rm -rf ${LFS}/usr/{,local/}{bin,include,lib,sbin,src}
as_root rm -rf ${LFS}/usr/{,local/}share/{color,dict,doc,info,locale,man}
as_root rm -rf ${LFS}/usr/{,local/}share/{misc,terminfo,zoneinfo}
as_root rm -rf ${LFS}/usr/libexec
as_root rm -rf ${LFS}/usr/{,local/}share/man/man{1..8}


as_root rm -rf ${LFS}/var/{cache,local,log,mail.opt,spool}
as_root rm -rf ${LFS}/var/lib/{color,locate,misc}
as_root rm -rf ${LFS}/{dev,mnt,opt,proc,srv,sys}
as_root install -dm755 ${LFS}/etc/{ld.so.conf.d,opt,profile.d} ${LFS}/run/lock

as_root rm -rf ${LFS}/var/run
as_root rm -rf ${LFS}/var/lock

as_root rm -rf ${LFS}/bin
 
as_root rm -rf ${LFS}/{boot,dev,home,media,mnt,opt,proc,srv,sys}
as_root rm -rf ${LFS}/etc/{ld.so.conf.d,opt,profile.d} ${LFS}/run/lock

as_root rm -rf ${LFS}/{,usr/}{bin,lib,lib32,sbin}
as_root rm -rf ${LFS}/usr/local/{bin,lib,sbin}

as_root rm -rf ${LFS}/usr/{,local/}{include,libexec,src}
as_root rm -rf ${LFS}/usr/{,local/}share/{color,dict,doc,info,locale,misc}
as_root rm -rf ${LFS}/usr/{,local/}share/man/man{1..8}

as_root rm -rf ${LFS}/var/{cache,local,log,mail,opt,spool}
as_root rm -rf ${LFS}/var/lib/{color,locate,misc}

as_root rm -rf ${LFS}/lib64

as_root rm -rf ${LFS}/var/run
as_root rm -rf ${LFS}/var/lock

as_root rm -rf ${LFS}/var/tmp
as_root rm -rf ${LFS}/root

echo "./1+clean-directories.sh ran"
