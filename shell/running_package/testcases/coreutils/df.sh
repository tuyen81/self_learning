#!/bin/bash
#==============================================================================
# DESCRIPTION: df.sh tests 'df' command of coreutils package.
#              Use 'df' command to get full summary of available and 
#              used disk space usage of file system on Linux system.
#              Search a key word in output to verify result
#==============================================================================
#run command df
df -ah --total > ${log_file} 2>&1

grep -nr "Filesystem" ${log_file} > /dev/null 2>&1

assert_passed $? 0
