#!/bin/bash
#==============================================================================
# DISCRIPTION: Test script is test to 'shuf' command.
#              The 'shuf' command use to generates random permutations from
#              input lines to standard output
#==============================================================================

check=0

# Run command generates random permutations in the first time
shuf -i 1-4 > ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

# Run command generates random permutations in the second time
shuf -i 1-4 >> ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

# Check result of command shuf with expected output
assert_passed $check 0
