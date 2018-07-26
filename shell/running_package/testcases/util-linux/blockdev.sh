#!/bin/bash

#===============================================================================
# DESCRIPTION: Make partiotion for storage device
#              Get size in 512-byte sectors and Get minimum I/O size of devices
#===============================================================================

. ${CONFIG_DIR}/get_disk.sh > ${log_file} 2>&1
check=0
mkdir test; cd test

blockdev --getsz ${TGTDEV} >> ${log_file} 2>&1

# Check command above error or not
if [ $? != "0" ]; then
  check=1
fi

blockdev -v --getiomin ${TGTDEV} >> ${log_file} 2>&1

# Check command above error or not
if [ $? != "0" ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0

cd ..

# Delete non-necessary file
rm -fr test
