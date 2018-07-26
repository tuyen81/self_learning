#!/bin/bash
#==============================================================================
# DESCRIPTION: iputils-arping.sh tests 'arping' command of iputils package.
#              Run 'arping' command to displays the Ethernet and IP address of
#              the target as well as the time elapsed between the arp request
#              and the arp reply.
#==============================================================================
check=0
. ${CONFIG_DIR}/network.sh

#Check reachability of an IP on the local Ethernet with arping
arping -c 4 -I $ethernet_interface "$des_ip_address" > ${log_file} 2>&1

#Check output result
grep -nr "ARPING $des_ip_address from" ${log_file} > /dev/null 2>&1

if [ $? != "0" ]; then
  check=1
fi

grep -nr "Sent 4 probes" ${log_file} > /dev/null 2>&1
if [ $? != "0" ]; then
  check=1
fi

# Check status of testcase
assert_passed $check 0
