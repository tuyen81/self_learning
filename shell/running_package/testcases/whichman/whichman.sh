#!/bin/bash

#===============================================================================
# DESCRIPTION: Create testing.1.gz file in /usr/share/man/man1/ directory
#              Run whichman command to find man page in man path
#===============================================================================

mkdir -p /usr/share/man/man1

touch /usr/share/man/man1/testing.1.gz > ${log_file} 2>&1

whichman testing | grep "/usr/share/man/man1/testing.1.gz" >> ${log_file} 2>&1

# Check result of testcase
assert_passed $? 0
