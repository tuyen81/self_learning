#!/bin/bash
#==============================================================================
# DESCRIPTION: dir.sh tests 'dir' command of coreutils package.
#              Use dir command to list information about current directory
#              Search a key word 'total' in output to verify result
#==============================================================================
#run command dir commnad to list information of current directory
dir -liQ > ${log_file} 2>&1

assert_passed $? 0
