#!/bin/bash

#==============================================================================
# DESCRIPTION: Modprobe bonding module then attach slave to bonding device
#==============================================================================

check=0

. $CONFIG_DIR/network.sh

echo "Testing ifenslave" > ${log_file}
# Load module bonding
modprobe bonding 2>> ${log_file}

# Attach slave network device to a bonding device
ifenslave bond0 $ethernet_interface >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0

# Revert to default config
modprobe -r bonding >> ${log_file} 2>&1
/etc/init.d/networking restart
