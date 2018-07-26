#!/bin/bash

#==============================================================================
# DESCRIPTION: This testcase open and display the content of file.gz compress file
#==============================================================================

echo "Testing perl-module-io-zlib" > ${log_file}
check=0

# Create file and directory for testing
cp -r ${data_dir} ${PWD}/test_pmzl >> ${log_file} 2>&1
cd ${PWD}/test_pmzl

# Open and display the content of file.gz
perl sample.pl | grep "Hello World!" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

cd ..

# Check result of testcase
assert_passed $check 0

# Remove noneeded files
rm -rf ${PWD}/test_pmzl
