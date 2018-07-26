#!/bin/bash
#==============================================================================
# DISCRIPTION: Test script is test to 'touch' command.
#              In test script 'touch' command used to check timestamps of a sample.txt file
#              The sample.txt file is created with size is 0 byte
#==============================================================================

check=0

# Create a directory and a sample.txt file with size is 0 byte for testing
mkdir -p ${data_dir}
touch  ${data_dir}/sample.txt

# Check timestamps of sample.txt file
ls -l ${data_dir}/sample.txt > ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

# Wait for 2 seconds, update timestamps of sample.txt file
sleep 2
touch ${data_dir}/sample.txt >> ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

# Check timestamps of sample.txt file
ls -l ${data_dir}/sample.txt >> ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

# Check result of command touch with expected output
assert_passed $check 0

# Remove directory and a sample.txt file for testing
rm -rf ${data_dir}
