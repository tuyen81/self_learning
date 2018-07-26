#!/bin/bash

#===============================================================================
# DESCRIPTION: Display message from kernel and displays a text file on 
#              a CRT one screenfuld
#===============================================================================

check=0

dmesg | more > ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

dmesg | pg >> ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

# Check test result
assert_passed $check 0
