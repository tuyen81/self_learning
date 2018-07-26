#!/bin/bash

#===============================================================================
# DESCRIPTION: Start, stop then restart sysfsutils service
#===============================================================================

check=0

echo "Testing sysfsutils" > ${log_file}
# Stop sysfsutils service
systemctl stop sysfsutils >> ${log_file} 2>&1
systemctl status -l sysfsutils | grep "Active: inactive (dead)" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Start sysfsutils service
systemctl start sysfsutils >> ${log_file} 2>&1
systemctl status -l sysfsutils | grep "Active: active (exited)" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Restart sysfsutils service
systemctl restart sysfsutils >> ${log_file} 2>&1
systemctl status -l sysfsutils | grep "Active: active (exited)" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0
