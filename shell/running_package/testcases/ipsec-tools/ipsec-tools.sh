#!/bin/bash

#==============================================================================
# DESCRIPTION: Start, stop and restart then check status of setkey service
#==============================================================================

check=0

# Stop service setkey before testing
systemctl stop setkey 2> ${log_file}
systemctl status -l setkey | grep "Active: inactive (dead)" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Start setkey service
systemctl start setkey 2> ${log_file}
systemctl status -l setkey | grep "Active: active (exited)" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Restart setkey service
systemctl restart setkey 2> ${log_file}
systemctl status -l setkey | grep "Active: active (exited)" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

assert_passed $check 0
