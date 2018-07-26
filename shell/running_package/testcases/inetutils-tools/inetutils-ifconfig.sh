#!/bin/bash

#===============================================================================
# DESCRIPTION: This testcase set specific IP address for ethernet interface and
#              check information of ethernet interface
#===============================================================================

. $CONFIG_DIR/network.sh

check=0
ip="10.0.2.10"
echo "Testing inetutils-tools" > ${log_file}

# Backup ethernet interface's information
info=`inetutils-ifconfig $ethernet_interface | grep "inet addr:" | cut -d':' -f2 | cut -d' ' -f1` >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Set specific IP address for ethernet interface
inetutils-ifconfig $ethernet_interface $ip >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

inetutils-ifconfig $ethernet_interface | grep "inet addr:$ip" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check information of ethernet interface
inetutils-ifconfig $ethernet_interface | grep "$ethernet_interface" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0

# Restore data
/etc/init.d/networking restart >> ${log_file} 2>&1
