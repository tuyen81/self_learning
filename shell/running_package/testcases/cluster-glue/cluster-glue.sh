#!/bin/bash

#==============================================================================
# DESCRIPTION: Start and stop logd service
#==============================================================================

check=0

echo "Testing cluster-glue" > ${log_file} 2>&1

# Stop logd service
systemctl stop logd >> ${log_file} 2>&1
systemctl status -l logd | grep "Active: inactive (dead)" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Start logd service
systemctl start logd >> ${log_file} 2>&1
systemctl status -l logd | grep "Active: active (running)" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0
