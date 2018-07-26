#!/bin/bash

#===============================================================================
# DESCRIPTION: Show listing of last logged in users
#===============================================================================

touch /var/log/wtmp

last | cut -f1 -d " " | grep root > ${log_file} 2>&1

# Check test result
assert_passed $? 0
