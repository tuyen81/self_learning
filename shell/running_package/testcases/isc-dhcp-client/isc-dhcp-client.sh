#!/bin/bash

#==============================================================================
# DESCRIPTION: Config ethX in /etc/network/interfaces file then renew IP using dhclient
#==============================================================================

interface=0

. $CONFIG_DIR/network.sh

# Get current ip address
ip=`ifconfig $ethernet_interface | grep "inet addr:" | cut -f2 -d":" | sed 's/ .*$//'`

echo "Testing for isc-dhcp-client" > ${log_file}

# Prepare /etc/network/interface file for testing
if [ -s /etc/network/interfaces ]; then
  mv /etc/network/interfaces /etc/network/interfaces.bak >> ${log_file}
  interface=1
fi

touch /etc/network/interfaces 2>> ${log_file}

sed -i "1s/^/auto $ethernet_interface\n/" /etc/network/interfaces 2>> ${log_file}
sed -i "2s/^/iface $ethernet_interface inet dhcp\n/" /etc/network/interfaces 2>> ${log_file}

service networking restart >> ${log_file} 2>&1

# Renew IP
dhclient -v &>> ${log_file} 2>&1

# Check result of testcase
assert_passed $? 0

# Revert to default config
rm /etc/network/interfaces
if [ $interface -eq 1 ]; then
  mv /etc/network/interfaces.bak /etc/network/interfaces
fi

service networking restart >> ${log_file} 2>&1
