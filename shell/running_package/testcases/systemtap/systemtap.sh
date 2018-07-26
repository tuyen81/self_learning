#!/bin/bash

#===============================================================================
# DESCiRIPTION: Check kernel headers, debug symbols and build tools on system
#               and run a SystemTap script program
#===============================================================================

check=0
echo "Testing systemtap" > ${log_file}

# Get system infomation
info=`uname -a | cut -d' ' -f3`

# Prepare system for systemtap use 
stap-prep >> ${log_file} 2>&1

# If system installed essential packages
if [ $? -ne 0 ]; then
  check=1
fi

# Run SystemTap script program
cat <<EOF> hello.stp
#! /usr/bin/env stap
probe oneshot { println("hello world") }
EOF

stap hello.stp | grep "hello world" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0
