#!/bin/bash

#===============================================================================
# DESCRIPTION: Stop udevd service before testing
#              Start, stop and restart service then check status of service
#===============================================================================

check=0

# Stop udev before test service
pkill -9 udevd > ${log_file} 2>&1

systemctl start udev >> ${log_file} 2>&1
sleep 4

systemctl status udev | grep "active (running)" >> ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

systemctl stop udev >> ${log_file} 2>&1
sleep 4

systemctl status udev | grep "inactive (dead)" >> ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

systemctl restart udev >> ${log_file} 2>&1
sleep 4

systemctl status udev | grep "active (running)" >> ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

assert_passed $check 0
