#!/bin/bash
#==============================================================================
# DISCRIPTION: Test script is test to 'uname' command.
#              The 'uname' is a command which prints system information like the kernel name
#==============================================================================

# Prints system information like the kernel name
uname -a > ${log_file} 2>&1

# Check result of command uname with expected output
assert_passed $? 0
