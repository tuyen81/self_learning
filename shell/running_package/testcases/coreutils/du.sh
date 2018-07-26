#!/bin/bash
#==============================================================================
# DESCRIPTION: du.sh is used to test 'du' command of coreutils package.
#              Use 'du' command to reports the sizes of directory trees inclusive
#              of all of their contents and the sizes of individual files
#==============================================================================
#run command du commnad to report the sizes of current directory
du -ac --max-depth=1 /var > ${log_file} 2>&1

assert_passed $? 0
