#!/bin/bash
#==============================================================================
# DESCRIPTION: echo.sh used to test 'echo' command of coreutils package.
#              Use echo command to writes its arguments to standard output.
#              Compare output to expected result to show test case pass or fail
#==============================================================================
#run command echo command to display string on standart output
echo -e "Hello\nThis is echo" > ${log_file} 2>&1

diff ${log_file} ${data_dir}/expected_result.txt 2>&1

assert_passed $? 0
