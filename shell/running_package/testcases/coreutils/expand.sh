#!/bin/bash
#==============================================================================
# DESCRIPTION: expand.sh is used to test 'expand' command of coreutils package.
#              Run 'expand' command to set tabs number characters apart equal 1.
#              Compare output to expected result to show test case pass or fail
#==============================================================================
#run expand command to set tabs NUMBER characters apart equal 1
echo -e "H\te\tl\tl\to" | expand -t 1 > ${log_file} 2>&1

diff ${log_file} ${data_dir}/expected_result.txt 2>&1

assert_passed $? 0
