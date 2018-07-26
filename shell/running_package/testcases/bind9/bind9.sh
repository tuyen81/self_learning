#!/bin/bash

#===============================================================================
# DESCRIPTION: Start, stop and restart bind9 service then check result
#===============================================================================

check=0
echo "Testing bind9" > ${log_file}

#Start bind9 service
systemctl start bind9 >> ${log_file} 2>&1
systemctl status -l bind9 | grep "Active: active (running)" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Wait till job finishes
sleep 2

# Stop bind9 service
systemctl stop bind9 >> ${log_file} 2>&1
systemctl status -l bind9 | grep "Active: inactive (dead)" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Wait till job finishes
sleep 2

# Restart bind9 service
systemctl restart bind9 >> ${log_file} 2>&1
systemctl status -l bind9 | grep "Active: active (running)" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0
