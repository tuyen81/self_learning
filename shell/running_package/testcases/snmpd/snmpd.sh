#!/bin/bash

#==============================================================================
# DESCRIPTION: Start, stop and restart then check status of snmpd service
#==============================================================================

check=0

# Stop service snmpd before testing.
systemctl stop snmpd 2> ${log_file}
systemctl status -l snmpd | grep "Active: inactive (dead)" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Start snmpd service
systemctl start snmpd 2> ${log_file}
systemctl status -l snmpd | grep "Active: active (running)" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Restart snmpd service
systemctl restart snmpd 2> ${log_file}
systemctl status -l snmpd | grep "Active: active (running)" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

assert_passed $check 0
