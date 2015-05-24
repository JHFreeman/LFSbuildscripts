#!/tools/bin/bash -e

source as_root.sh

export LFS=/mnt/lfs

umask 022

as_root mkdir -pv /{bin,boot,etc/{opt,sysconfig},home,lib/firmware,mnt,opt}
as_root mkdir -pv /{media/{floppy,cdrom},sbin,srv,var}
as_root install -dv -m 0750 /root
as_root install -dv -m 1777 /tmp /var/tmp
as_root mkdir -pv /usr/{,local/}{bin,include,lib,sbin,src}
as_root mkdir -pv /usr/{,local/}share/{color,dict,doc,info,locale,man}
as_root mkdir -v  /usr/{,local/}share/{misc,terminfo,zoneinfo}
as_root mkdir -v  /usr/libexec
as_root mkdir -pv /usr/{,local/}share/man/man{1..8}

case $(uname -m) in
 x86_64) as_root ln -sv lib /lib64
         as_root ln -sv lib /usr/lib64
         as_root ln -sv lib /usr/local/lib64 ;;
esac

as_root mkdir -v /var/{log,mail,spool}
as_root ln -sv ../run /var/run
as_root ln -sv ../run/lock /var/lock
as_root mkdir -pv /var/{opt,cache,lib/{color,misc,locate},local}
echo "./5-creating-directories.sh ran"
