#!/bin/bash
#==============================================================================
# DESCRIPTION: iputils-ping tests 'ping' command of iputils package.
#              Use 'ping' command to test connectivity between host pc and
#              destination ip address.
#              'Ping' command show number of package transmited, received,
#              loss and time to stdout.
#==============================================================================
. ${CONFIG_DIR}/network.sh
#Ping to another PC in LAN network
if [ -x /bin/ping.iputils ]; then
  ping.iputils -RD -i 5 -w 10 $des_ip_address > ${log_file} 2>&1
else
  ping -RD -i 5 -w 10 $des_ip_address > ${log_file} 2>&1
fi
grep -nr 'icmp_seq=2 ttl=' ${log_file} >> /dev/null 2>&1

assert_passed $? 0
