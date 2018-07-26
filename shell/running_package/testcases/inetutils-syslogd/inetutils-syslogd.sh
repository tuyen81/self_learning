#!/bin/bash

#===============================================================================
# DESCRIPTION: Check status of inetutils-syslogd service after start, 
#              stop and restart inetutils-syslogd
#===============================================================================

check=0
echo "Testing inetutils-syslogd" > ${log_file}

# Start inetutils-syslogd service
systemctl start inetutils-syslogd  >> ${log_file} 2>&1
systemctl status -l inetutils-syslogd | grep "Active: active (" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Stop inetutils-syslogd service
systemctl stop inetutils-syslogd  >> ${log_file} 2>&1
systemctl status -l inetutils-syslogd | grep "Active: inactive (" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Restart inetutils-syslogd service
systemctl restart inetutils-syslogd  >> ${log_file} 2>&1
systemctl status -l inetutils-syslogd | grep "Active: active (" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0
