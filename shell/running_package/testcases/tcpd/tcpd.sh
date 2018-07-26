#!/bin/bash

#===============================================================================
# DESCRIPTION: tcpdchk reports  problems such as access, daemons, client, server
#              control file was located in /etc/hosts.allow and /etc/hosts.deny
#              tcpdmatch  finds  a  match in the access control tables
#              after rund two command above, revert to default config 
#===============================================================================

check_allow=0
check_deny=0
check_inetd=0

# Check and save previous data
if [ -s /etc/hosts.allow ]; then
mv /etc/hosts.allow /etc/hosts.allow.bak
check_allow=1
fi

# Check and save previous data
if [ -s /etc/hosts.deny ]; then
mv /etc/hosts.deny /etc/hosts.deny.bak
check_deny=1
fi

rm -fr /etc/hosts.allow /etc/hosts.deny

# Create file /etc/hosts.deny and /etc/hosts.allow
echo "ALL: ALL" > /etc/hosts.deny
echo "ALL: localhost" > /etc/hosts.allow

# Check and save previous data
if [ -s /etc/inetd.conf ]; then
mv /etc/inetd.conf /etc/inetd.conf.bak
check_inetd=1
fi

rm -fr /etc/inetd.conf

# Create content for network configuration file
echo "sshd stream  tcp6    nowait  root    /usr/sbin/tcpd      sshd -a" > /etc/inetd.conf

mv /etc/hosts /etc/hosts.bak

rm -fr /etc/hosts

echo "127.0.0.1	localhost" > /etc/hosts

tcpdchk -v > ${PWD}/output.txt

tcpdmatch sshd localhost >> ${PWD}/output.txt

sed -i '/matched/d' ${PWD}/output.txt

diff ${PWD}/output.txt ${data_dir}/output_expected.txt > ${PWD}/test.txt

cat ${PWD}/test.txt  > ${log_file} 2>&1

# Check result of testcase
if [ -s ${PWD}/test.txt ]; then
  echo "${test_failed_text}" >> ${RESULT_FILE}
else
  echo "${test_passed_text}" >> ${RESULT_FILE}
fi

# Remove non-necessary files and revert previous configurations
rm -fr /etc/hosts.allow /etc/hosts.deny /etc/inetd.conf /etc/hosts test.txt output.txt

/etc/init.d/networking restart >> ${log_file} 2>&1

mv /etc/hosts.bak /etc/hosts

if [ $check_allow != "0" ]; then
mv /etc/hosts.allow.bak /etc/hosts.allow
fi

if [ $check_inetd != "0" ]; then
mv /etc/inetd.conf.bak /etc/inetd.conf
fi

if [ $check_deny != "0" ]; then
mv /etc/hosts.deny.bak /etc/hosts.deny
fi
