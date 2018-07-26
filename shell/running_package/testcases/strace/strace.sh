#!/bin/bash

#===============================================================================
# DESCRIPTION: Run strace command to trace ls command with non-existed file
#              trace ls command with existed file
#===============================================================================

check=0

strace ls anythinghere &> ${PWD}/test.txt
grep "write(1" ${PWD}/test.txt > ${log_file} 2>&1

if [ $? = "0" ]; then
 check=1
fi

strace ls &> ${PWD}/test.txt
grep "write(1" ${PWD}/test.txt >> ${log_file} 2>&1

if [ $? != "0" ]; then
 check=1
fi

# Check result of testcase
assert_passed $check 0

# Remove non-necessary file
rm -fr ${PWD}/test.txt
