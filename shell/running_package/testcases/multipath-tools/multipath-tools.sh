#!/bin/bash

#===============================================================================
# DESCRIPTION: Check status of multipath-tools service after start, 
#              stop and restart multipath-tools
#===============================================================================

check=0
echo "Testing multipath-tools" > ${log_file}

# Start multipath-tools service
systemctl start multipath-tools  >> ${log_file} 2>&1
systemctl status -l multipath-tools | grep "Active: active (" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Stop multipath-tools service
systemctl stop multipath-tools  >> ${log_file} 2>&1
systemctl status -l multipath-tools | grep "Active: inactive (" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Restart multipath-tools service
systemctl restart multipath-tools  >> ${log_file} 2>&1
systemctl status -l multipath-tools | grep "Active: active (" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0
