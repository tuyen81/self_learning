#!/bin/bash
#==============================================================================
# DESCRIPTION: hostid is used to testing hostid command of coreutils package.
#              Use hostid command to Print the numeric identifier for the 
#              current host
#              Compare the output and expected result to verify the result
#==============================================================================
#Print the numeric identifier for the current host
hostid > ${log_file} 2>&1

assert_passed $? 0
