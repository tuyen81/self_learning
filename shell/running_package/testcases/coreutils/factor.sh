#!/bin/bash
#==============================================================================
# DESCRIPTION: factor.sh is used to testing 'factor' command of coreutils package
#              Use 'factor' command to print the prime factors of all specified
#              integer NUMBERs.
#              If no arguments are specified on the command line, they are
#              read from standard input
#              Compare output to expected result to show result of testcase
#==============================================================================
#run command factor
factor 210 > ${log_file} 2>&1
#Compare expected result and output
diff ${data_dir}/expected_result.txt ${log_file} > /dev/null 2>&1

assert_passed $? 0
