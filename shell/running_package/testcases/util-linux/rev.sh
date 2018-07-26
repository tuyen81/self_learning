#!/bin/sh

#===============================================================================
# DESCRIPTION: Run rev command with 'Hello' string to Reverse 'Hello' string
#              to 'olleH' string
#===============================================================================

echo Hello | rev > ${log_file} 2>&1

grep "olleH" ${log_file} > /dev/null

# Check result of testcase
assert_passed $? 0
