#!/bin/bash

#==============================================================================
# DESCRIPTION: Testing for cat command.
#              The cat command is used to print a file on the standard output.
#==============================================================================

cat ${data_dir}/sample.txt > ${log_file} 2>&1

diff ${data_dir}/sample.txt ${log_file}

assert_passed $? 0
