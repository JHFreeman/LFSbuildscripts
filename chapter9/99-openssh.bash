#!/bin/bash -e

source get_dir.bash

FILE="openssh-6.8p1.tar.gz"
DIR=${FILE%.tar.gz}
export CFLAGS="-march=native -pipe -O2 -fstack-protector-strong -mavx"
export CXXFLAGS="-march=native -pipe -O2 -fstack-protector-strong -mavx"
trap 'echo '$DIR'; times' EXIT
pushd /sources

tar -xf ${FILE}

cd $DIR

if [ ! -d /var/lib/sshd ]; then
	install -v -m700 -d /var/lib/sshd 
fi &&
chown   -v root:sys /var/lib/sshd &&

if ! grep -qs "sshd" /etc/group; then
	groupadd -g 50 sshd 
fi &&

if ! grep -qs "sshd" /etc/passwd; then
	useradd -c 'sshd PrivSep' -d /var/lib/sshd -g sshd -s /bin/false -u 50 sshd
fi

./configure --prefix=/usr                     \
            --sysconfdir=/etc/ssh             \
            --with-md5-passwords              \
            --with-privsep-path=/var/lib/sshd &&
make

make install                                  &&
install -v -m755 contrib/ssh-copy-id /usr/bin

echo "PermitRootLogin no" >> /etc/ssh/sshd_config

ssh-keygen &&
ssh-copy-id -i ~/.ssh/id_rsa.pub john@brainkernel.com

echo "PasswordAuthentication no" >> /etc/ssh/sshd_config &&
echo "ChallengeResponseAuthentication no" >> /etc/ssh/sshd_config

cd ..

cd blfs-bootscripts-20150304

make install-sshd

cd ..

rm -rf $DIR

popd