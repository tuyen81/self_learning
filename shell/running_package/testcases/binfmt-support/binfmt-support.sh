#!/bin/bash
#
#==============================================================================
# DESCRIPTION: Testing for binfmt-support command.
#              Start, stop and restart binfmt-support service then check 
#              result.
#              Enable and disable all binary formats then check result.
#==============================================================================

check=0
echo "Testing binfmt-support" > ${log_file}

# Start binfmt-support service
service binfmt-support start >> ${log_file} 2>&1
if [ $? -ne 0 ]; then
  check=1
fi

# Stop binfmt-support service
service binfmt-support stop >> ${log_file} 2>&1
if [ $? -ne 0 ]; then
  check=1
fi

# Restart binfmt-support service
service binfmt-support restart >> ${log_file} 2>&1
if [ $? -ne 0 ]; then
  check=1
fi

# Enable all known binary formats
update-binfmts --enable >> ${log_file} 2>&1
update-binfmts --display | grep "disabled" >> ${log_file} 2>&1
if [ $? -eq 0 ]; then
  check=1
fi

# Disable all known binary formats
update-binfmts --disable >> ${log_file} 2>&1
update-binfmts --display | grep "enabled" >> ${log_file} 2>&1
if [ $? -eq 0 ]; then
  check=1
fi

# Re-enable all known binary formats
update-binfmts --enable >> ${log_file} 2>&1
update-binfmts --display | grep "disabled" >> ${log_file} 2>&1
if [ $? -eq 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0

