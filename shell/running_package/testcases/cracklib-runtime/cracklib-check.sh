#!/bin/bash

#==============================================================================
# DESCRIPTION: Testing for cracklib-check command.
#              The cracklib-check command is used to check a list of passwords 
#              from stdin and check output is "OK" or "it is based on a dictionary word".
#==============================================================================

. ${data_dir}/run_cracklib-check.sh > ${log_file} 2>&1

diff ${log_file} ${data_dir}/expected_output >> ${log_file} 2>&1

assert_passed $? 0
