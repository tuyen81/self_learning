#!/bin/bash

#==============================================================================
# DESCRIPTION: Start, stop and restart fam service and run famd with timeout option
#==============================================================================

check=0

echo "Testing fam" > ${log_file}

# Make sure that rpcbind service was started successfully
systemctl restart rpcbind >> ${log_file} 2>&1
sleep 2
systemctl status -l rpcbind | grep "Active: active (running)" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# check fam service
systemctl restart fam >> ${log_file} 2>&1
sleep 2
systemctl status -l fam | grep "Active: active (running)" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

systemctl stop fam >> ${log_file} 2>&1
sleep 2
systemctl status -l fam | grep "Active: inactive (dead)" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

systemctl start fam >> ${log_file} 2>&1
sleep 2
systemctl status -l fam | grep "Active: active (running)" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Run famd with -T (timeout) option
famd -T 5
if [ $? -ne 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0
