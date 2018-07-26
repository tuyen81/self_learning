#!/bin/bash

#===============================================================================
# DESCRIPTION: Check start, stop and restart function of pcscd
#===============================================================================

check=0
echo "Testing pcscd" > ${log_file}

# Start pcscd service
systemctl start pcscd  >> ${log_file} 2>&1
systemctl status -l pcscd | grep "Active: active (" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Wait till job finishes
sleep 2

# Stop pcscd service
systemctl stop pcscd  >> ${log_file} 2>&1
systemctl status -l pcscd | grep "Active: failed (" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Wait till job finishes
sleep 2

# Restart pcscd service
systemctl restart pcscd  >> ${log_file} 2>&1
systemctl status -l pcscd | grep "Active: active (" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0
