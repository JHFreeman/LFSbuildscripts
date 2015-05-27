#!/tools/bin/bash -e



export LFS=/mnt/lfs

umask 022

for dir in /{bin,boot,etc/{opt,sysconfig},home,lib/firmware,mnt,opt}
do
	if [ ! -d $dir ]; then
		mkdir -pv $dir
	fi
done

for dir in /{media/{floppy,cdrom},sbin,srv,var}
do
	if [ ! -d $dir ]; then
		mkdir -pv $dir
	fi
done
#mkdir -pv /{bin,boot,etc/{opt,sysconfig},home,lib/firmware,mnt,opt}
#mkdir -pv /{media/{floppy,cdrom},sbin,srv,var}
if [ ! -d /root ]; then
	install -dv -m 0750 /root
fi
if [ ! -d /tmp ]; then
	install -dv -m 1777 /tmp
fi
if [ ! -d /var/tmp ]; then
	install -dv -m 1777 /var/tmp
fi
#install -dv -m 1777 /tmp /var/tmp
for dir in /usr/{,local/}{bin,include,lib,sbin,src}
do
	if [ ! -d $dir ]; then
		mkdir -pv $dir
	fi
done
#mkdir -pv /usr/{,local/}{bin,include,lib,sbin,src}

for dir in /usr/{,local/}share/{color,dict,doc,info,locale,man}
do
	if [ ! -d $dir ]; then
		mkdir -pv $dir
	fi
done
#mkdir -pv /usr/{,local/}share/{color,dict,doc,info,locale,man}

for dir in /usr/{,local/}share/{misc,terminfo,zoneinfo}
do
	if [ ! -d $dir ]; then
		mkdir -v $dir
	fi
done
#mkdir -v  /usr/{,local/}share/{misc,terminfo,zoneinfo}
if [ ! -d /usr/libexec ]; then
	mkdir -v /usr/libexec
fi
#mkdir -v  /usr/libexec
for dir in /usr/{,local/}share/man/man{1..8}
do
	if [ ! -d $dir ]; then
		mkdir -pv $dir
	fi
done
#mkdir -pv /usr/{,local/}share/man/man{1..8}

case $(uname -m) in
 x86_64) 
 		if [ ! -h /lib64 ]; then
 			ln -sv lib /lib64
 		fi
 		if [ ! -h /usr/lib64 ]; then
        	ln -sv lib /usr/lib64
        fi
        if [ ! -h /usr/local/lib64 ]; then
        	ln -sv lib /usr/local/lib64
        fi
        ;;
esac

for dir in log mail spool
do
	if [ ! -d /var/$dir ]; then
		mkdir -v /var/$dir
	fi
done
#mkdir -v /var/{log,mail,spool}
if [ ! -h /var/run ]; then
	ln -sv ../run /var/run
fi
if [ ! -h /var/lock ]; then
	ln -sv ../run/lock /var/lock
fi

for dir in /var/{opt,cache,lib/{color,misc,locate},local}
do
	if [ ! -d $dir ]; then
		mkdir -pv $dir
	fi
done
#mkdir -pv /var/{opt,cache,lib/{color,misc,locate},local}
