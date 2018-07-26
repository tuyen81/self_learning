#!/bin/bash

#===============================================================================
# DESCRIPTION: Check status of inetutils-inetd service after start, 
#              stop and restart inetutils-inetd
#===============================================================================

check=0
echo "Testing inetutils-inetd" > ${log_file}

# Start inetutils-inetd service
systemctl start inetutils-inetd  >> ${log_file} 2>&1
systemctl status -l inetutils-inetd | grep "Active: active (" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Stop inetutils-inetd service
systemctl stop inetutils-inetd  >> ${log_file} 2>&1
systemctl status -l inetutils-inetd | grep "Active: inactive (" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Restart inetutils-inetd service
systemctl restart inetutils-inetd  >> ${log_file} 2>&1
systemctl status -l inetutils-inetd | grep "Active: active (" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0
