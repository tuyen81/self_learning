#!/bin/bash

#==============================================================================
# DESCRIPTION: Use bash command to run a script file and print a string to stdout.
#==============================================================================

bash ${data_dir}/sample.sh > ${log_file} 2>&1

diff ${log_file} ${data_dir}/expected_output >> ${log_file} 2>&1

assert_passed $? 0
