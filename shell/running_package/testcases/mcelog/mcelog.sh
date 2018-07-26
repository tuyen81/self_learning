#!/bin/bash
#
#==============================================================================
# DESCRIPTION: Testing for mcelog command.
#              Start, stop and restart mcelog service then check result.
#==============================================================================

check=0
echo "Testing mcelog" > ${log_file}

# Start mcelog service
service mcelog start >> ${log_file} 2>&1
if [ $? -ne 0 ]; then
  check=1
fi

# Stop mcelog service
service mcelog stop >> ${log_file} 2>&1
if [ $? -ne 0 ]; then
  check=1
fi

# Restart mcelog service
service mcelog restart >> ${log_file} 2>&1
if [ $? -ne 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0

