#!/bin/bash

#==============================================================================
# DESCRIPTION: Test get file and put file fuctions using ftp.
#              Create user for ftp login and check result after get and put file.
#==============================================================================

check=0

# Enable writes, to test both get and put
cp /etc/vsftpd.conf /etc/vsftpd.conf.bak
sed -i 's/^#\(write_enable=YES\)$/\1/' /etc/vsftpd.conf
service vsftpd reload > ${log_file} 2>&1

# Create test user

mkdir -p /home
useradd -m ftptest
echo ftptest:dep8|chpasswd ftptest

# Set up .netrc so that the ftp client can login in automatically
> ~ftptest/.netrc
chown ftptest: ~ftptest/.netrc
chmod 600 ~ftptest/.netrc
cat > ~ftptest/.netrc <<EOT
machine localhost
login ftptest
password dep8
EOT

# Test get and put

mkdir ~ftptest/local ~ftptest/remote
echo "Hello, world! 1." > ~ftptest/local/put
echo "Hello, world! 2." > ~ftptest/remote/get
chown -R ftptest: ~ftptest/local ~ftptest/remote

su -c 'ftp localhost' - ftptest >> ${log_file} 2>&1 <<EOT
dep8
lcd local
cd remote
get get
put put
quit
EOT

cmp ~ftptest/local/put ~ftptest/remote/put
if [ $? != "0" ]; then
  check=1
fi
cmp ~ftptest/local/get ~ftptest/remote/get
if [ $? != "0" ]; then
  check=1
fi

assert_passed $check 0

userdel ftptest
mv /etc/vsftpd.conf.bak /etc/vsftpd.conf
rm -rf /home/ftptest
