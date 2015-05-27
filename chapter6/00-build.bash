#!/bin/bash -e

if [ ! -z $1 ]; then
	stage=$1
	trap times && echo "chapter6:Stage:$stage" EXIT
fi



if [[ $((stage)) -eq 1 ]]; then
	source 02-preparing.bash
	source 04-enter-chroot.bash
elif [[ $((stage)) -eq 2 ]]; then
	source 05-creating-directories.bash
	source 06-file-and-symlinks.bash
elif [[ $((stage)) -eq 3 ]]; then
	source 07-api-headers.bash
	source 08-man-pages.bash
	source 09-glibc.bash
	source 10-adjusting.bash
	source 11-zlib.bash
	source 12-file.bash
	source 13-binutils.bash
	source 14-gmp.bash
	source 15-mpfr.bash
	source 16-mpc.bash
	source 17-gcc.bash
	source 18-bzip2.bash
	source 19-pkg-config.bash
	source 20-ncurses.bash
	source 21-attr.bash
	source 22-acl.bash
	source 23-libcap.bash
	source 24-sed.bash
	source 25-shadow.bash
	source 26-psmisc.bash
	source 27-procps-ng.bash
	source 28-e2fsprogs.bash
	source 29-coreutils.bash
	source 30-iana-etc.bash
	source 31-m4.bash
	source 32-flex.bash
	source 33-bison.bash
	source 34-grep.bash
	source 35-readline.bash
	source 36-bash.bash
elif [[ $((stage)) -eq 4 ]]; then
	source 37-bc.bash
	source 38-libtool.bash
	source 39-gdbm.bash
	source 40-expat.bash
	source 41-inetutils.bash
	source 42-perl.bash
	source 43-XML-Parser.bash
	source 44-autoconf.bash
	source 45-automake.bash
	source 46-diffutils.bash
	source 47-gawk.bash
	source 48-findutils.bash
	source 49-gettext.bash
	source 50-intltool.bash
	source 51-gperf.bash
	source 52-groff.bash
	source 53-xz.bash
	source 54-grub.bash
	source 55-less.bash
	source 56-gzip.bash
	source 57-iproute.bash
	source 58-kbd.bash
	source 59-kmod.bash
	source 60-libpipeline.bash
	source 61-make.bash
	source 62-patch.bash
	source 63-systemd.bash
	source 64-dbus.bash
	source 65-util-linux.bash
	source 66-man-db.bash
	source 67-tar.bash
	source 68-texinfo.bash
	source 69-vim.bash
else
	echo "Please specify a valid stage of the build to process"
fi
