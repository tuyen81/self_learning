#!/bin/bash

#===============================================================================
# DESCRIPTION: Start, stop then restart smartmontools service
#===============================================================================

check=0

echo "Testing smartmontools" > ${log_file}
# Stop smartmontools service
systemctl stop smartmontools >> ${log_file} 2>&1
systemctl status -l smartmontools | grep "Active: inactive (dead)" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Start smartmontools service
systemctl start smartmontools >> ${log_file} 2>&1
systemctl status -l smartmontools | grep "Active: active (running)" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Restart smartmontools service
systemctl restart smartmontools >> ${log_file} 2>&1
systemctl status -l smartmontools | grep "Active: active (running)" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0
