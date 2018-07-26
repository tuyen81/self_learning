#!/bin/bash

#===============================================================================
# DESCRIPTION: Check status of lsyncd service after start, stop and restart lsyncd
#===============================================================================

check=0
echo "Testing lsyncd" > ${log_file}

# Start lsyncd service
systemctl start lsyncd  >> ${log_file} 2>&1
systemctl status -l lsyncd | grep "Active: active (" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Stop lsyncd service
systemctl stop lsyncd  >> ${log_file} 2>&1
systemctl status -l lsyncd | grep "Active: inactive (" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Restart lsyncd service
systemctl restart lsyncd  >> ${log_file} 2>&1
systemctl status -l lsyncd | grep "Active: active (" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0
