#!/bin/bash

#==============================================================================
# DESCRIPTION: Config ethX interface in /etc/network/interface file then 
#              test ethX with  ifup and ifdown 
#==============================================================================

check=0
interface=0

. $CONFIG_DIR/network.sh

# Get current ip address
ip=`ifconfig $ethernet_interface | grep "inet addr:" | cut -f2 -d":" | sed 's/ .*$//'`

echo "Testing for ifupdown" > ${log_file}
# Prepare /etc/network/interface file for testing
if [ -s /etc/network/interfaces ]; then
  mv /etc/network/interfaces /etc/network/interfaces.bak >> ${log_file}
  interface=1
fi

cp ${data_dir}/interface /etc/network/interfaces 2>> ${log_file}

sed -i "1s/^/auto $ethernet_interface\n/" /etc/network/interfaces 2>> ${log_file}
sed -i "2s/^/iface $ethernet_interface inet static\n/" /etc/network/interfaces 2>> ${log_file}

service networking restart >> ${log_file} 2>&1
service networking restart >> ${log_file} 2>&1
systemctl daemon-reload >> ${log_file} 2>&1

# Test ifup
ifup $ethernet_interface >> ${log_file} 2>&1
ifconfig $ethernet_interface | grep "inet addr:192.0.2.7" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Test ifdown
ifdown $ethernet_interface >> ${log_file} 2>&1
ifconfig $ethernet_interface | grep "inet addr:" >> ${log_file} 2>&1

if [ $? -eq 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0

# Revert to default config
ifup $ethernet_interface
rm /etc/network/interfaces
if [ $interface -eq 1 ]; then
  mv /etc/network/interfaces.bak /etc/network/interfaces
fi

ifconfig $ethernet_interface $ip
service networking restart >> ${log_file} 2>&1
service networking restart >> ${log_file} 2>&1
