#!/bin/bash

#==============================================================================
# DESCRIPTION: Run sample.pl file using perl command
#              Output include index.html, wget_log file
#==============================================================================

echo "Testing perl-module-ipc-cmd" > ${log_file}

check=0
# Create directory for testing
mkdir -p ${PWD}/test
cd ${PWD}/test

# Run perl script using perl
perl ${data_dir}/sample.pl >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Get created file info
ls | grep "wget-log" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

cd ../
# Check result of testcase
assert_passed $check 0

# Remove noneeded files
rm -rf ${PWD}/test
