#!/bin/bash
#==============================================================================
# DISCRIPTION: Test script is test to 'who' command.
#              The 'who' command gets information about all users who
#              are currently logged in system
#==============================================================================

# Gets information about all users who are currently logged in system
who -a > ${log_file} 2>&1

# Check result of command who with expected output
assert_passed $? 0
