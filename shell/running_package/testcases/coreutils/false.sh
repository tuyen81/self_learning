#!/bin/bash
#==============================================================================
# DESCRIPTION: Testing for false command of coreutils package
#              Use command false to exit with a status code indicating failure
#              Check exit status after command false
#==============================================================================

false ls > ${log_file} 2>&1

#check exit status after command "false"
assert_passed $? 1
