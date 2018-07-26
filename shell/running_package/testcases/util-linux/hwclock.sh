#!/bin/bash

#===============================================================================
# DESCRIPTION: This testcase set the Hardware Clock to specific time and
#              set the Hardware Clock to the current System Time.
#===============================================================================

check=0
echo "Testing hwclock" > ${log_file}

# Set the Hardware Clock to specific time
hwclock --set --date="2010-10-10 10:10:10" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check Hardware Clock afer set to specific time
hwclock | grep "10:10:" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Set the Hardware Clock to the current System Time
hwclock -w >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0
