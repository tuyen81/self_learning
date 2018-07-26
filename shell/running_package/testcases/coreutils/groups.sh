#!/bin/bash
#==============================================================================
# DESCRIPTION: groups.sh is used to testing groups command of coreutils package
#              Run command groups root to show which group user 'root' is
#              Search keyword of output to check result
#==============================================================================
#Check group which user "root" is in
groups root > ${log_file} 2>&1

#Compare expected result and output
grep -nr "root" > /dev/null 2>&1

assert_passed $? 0
