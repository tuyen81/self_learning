#!/bin/bash
#==============================================================================
# DESCRIPTION: lbracket.sh is to test bracket '[' command of coreutils package.
#              Use bracket '[ command to execute comparing two integer number.
#              Compare '1' and '2' then show result to stdout
#              Compare output to expected result to show test case pass or fail
#==============================================================================
#run "[" command to compare value
if [ 1 -le 2 ];then echo "Hello"; fi > ${log_file} 2>&1

diff ${log_file} ${data_dir}/expected_result.txt > /dev/null 2>&1

assert_passed $? 0
