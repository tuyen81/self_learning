#!/bin/sh

#===============================================================================
# DESCRIPTION: Copy one line and up to a newline from stdin to stdout
#===============================================================================


echo -e "Line1\nLine2" | line > ${log_file} 2>&1

grep "Line1" ${log_file} > /dev/null

# Check result of testcase
assert_passed $? 0
