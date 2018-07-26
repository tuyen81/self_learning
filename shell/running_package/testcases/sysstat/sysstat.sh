#!/bin/bash

#===============================================================================
# DESCRIPTION: Use pidstat to monitoring individual tasks currently being managed 
#              by the Linux kernel
#              Use iostat command to monitoring system input/output device
#              loading by observing the time the devices are  active in 
#              relation to their average transfer rates
#===============================================================================

check=0
sar.sysstat 1 3 > ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

pidstat >> ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

iostat >> ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0
