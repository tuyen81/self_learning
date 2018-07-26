#!/bin/bash

#==============================================================================
# DESCRIPTION: Start, stop and restart then check status of xinetd service
#==============================================================================

check=0

# Stop service xinetd before testing
systemctl stop xinetd 2> ${log_file}
systemctl status -l xinetd | grep "Active: inactive (dead)" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Start xinetd service
systemctl start xinetd 2> ${log_file}
systemctl status -l xinetd | grep "Active: active (running)" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Restart xinetd service
systemctl restart xinetd 2> ${log_file}
systemctl status -l xinetd | grep "Active: active (running)" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

assert_passed $check 0
