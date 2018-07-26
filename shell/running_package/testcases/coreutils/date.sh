#!/bin/bash

#==============================================================================
# DESCRIPTION: Testing for date command of coreutils package.
#              Get date time of 2147483647 seconds since the epoch (1970-01-01 UTC)
#==============================================================================

check=0

# 2147483647 seconds since the epoch (1970-01-01 UTC)
expected_output="01/19/2038 03:14:07 UTC"
actual_output=`date -u --date='@2147483647' "+%m/%d/%Y %H:%M:%S %Z"`

if [ "$expected_output" = "$actual_output" ]; then
	check=1
fi

assert_passed $check 1
