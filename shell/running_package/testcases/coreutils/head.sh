#!/bin/bash
#==============================================================================
# DESCRIPTION: head.sh is to test head command of coreutils package.
#              Use head command to print the first 5 lines of each FILE to
#              standard output by using option -5
#              Compare output to expected result
#==============================================================================
#run command head to print the first 5 lines of sample.txt file
head -5 ${data_dir}/sample.txt > ${log_file} 2>&1

#compare output and expected result
diff ${log_file} ${data_dir}/expected_result.txt > /dev/null 2>&1

assert_passed $? 0
