#!/bin/bash

#===============================================================================
# DESCRIPTION: Check start, stop and restart function of openbsd-inetd
#===============================================================================

check=0
echo "Testing openbsd-inetd" > ${log_file}

# Start openbsd-inetd service
systemctl start openbsd-inetd  >> ${log_file} 2>&1
systemctl status -l openbsd-inetd | grep "Active: active (" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Stop openbsd-inetd service
systemctl stop openbsd-inetd  >> ${log_file} 2>&1
systemctl status -l openbsd-inetd | grep "Active: inactive (" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Restart openbsd-inetd service
systemctl restart openbsd-inetd  >> ${log_file} 2>&1
systemctl status -l openbsd-inetd | grep "Active: active (" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0
