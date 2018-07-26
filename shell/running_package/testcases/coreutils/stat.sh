#!/bin/bash
#==============================================================================
# DISCRIPTION: Test script is test to 'stat' command.
#              In test script behavior of 'stat' command is used for displaying
#              status information of Linux files and file systems
#==============================================================================

check=0

# Run "stat" command to displaying status information of Linux files and file systems
stat -f /root >> ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

expect_permission=`ls -ld /root | cut -d' ' -f1`
stat --format "%A" /root | grep "${expect_permission}" >> ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

# Check result of command stat with expected output
assert_passed $check 0
