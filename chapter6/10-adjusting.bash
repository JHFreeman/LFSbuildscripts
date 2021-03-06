#!/tools/bin/bash -e

trap 'echo adjusting; times' EXIT

mv -v /tools/bin/{ld,ld-old}
mv -v /tools/$(gcc -dumpmachine)/bin/{ld,ld-old}
mv -v /tools/bin/{ld-new,ld}
ln -sv /tools/bin/ld /tools/$(gcc -dumpmachine)/bin/ld
    
gcc -dumpspecs | sed -e 's@/tools@@g'                   \
    -e '/\*startfile_prefix_spec:/{n;s@.*@/usr/lib/ @}' \
    -e '/\*cpp:/{n;s@$@ -isystem /usr/include@}' >      \
    `dirname $(gcc --print-libgcc-file-name)`/specs

echo 'main(){}' > dummy.c
cc dummy.c -v -Wl,--verbose &> dummy.log
readelf -l a.out | grep ': /lib' > 10-adjusting.log

grep -o '/usr/lib.*/crt[1in].*succeeded' dummy.log >> 10-adjusting.log

grep -B1 '^ /usr/include' dummy.log >> 10-adjusting.log

grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g' >> 10-adjusting.log

grep "/lib.*/libc.so.6 " dummy.log >> 10-adjusting.log

grep found dummy.log >> 10-adjusting.log

rm -v dummy.c a.out dummy.log
