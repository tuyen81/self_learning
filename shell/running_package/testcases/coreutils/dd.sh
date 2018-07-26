#!/bin/bash
#==============================================================================
# DESCRIPTION: dd.sh tests 'dd' command of coreutils package.
#              Use 'dd' command to copy files: input /dev/zero output is sample.img
#              Search a key word in stdout to show result
#==============================================================================
#run command dd
dd if=/dev/zero of=sample.img bs=1k count=256 > ${log_file} 2>&1
grep -nr "copied" ${log_file} > /dev/null 2>&1

assert_passed $? 0

rm -rf sample.img
