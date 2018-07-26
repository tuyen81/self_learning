#!/bin/bash

#===============================================================================
# DESCRIPTION: lsusb display list of device was plugged on
#              usb-devices display detail info of USB buses in the system and the
#              devices was list above 
#===============================================================================

check=0

lsusb > ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

usb-devices >> ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0
