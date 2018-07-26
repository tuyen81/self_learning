#!/bin/bash

#===============================================================================
# DESCRIPTION: This testcase create sample.txt file then compress and decompress
#              a compressed file using lzop command
#===============================================================================

check=0
echo "Testing lzop" > ${log_file}

# Create sample.txt file for testing
mkdir ${PWD}/test_lzop >> ${log_file} 2>&1
cd ${PWD}/test_lzop

touch sample.txt >> ${log_file} 2>&1

# Compress sample.txt file
lzop -U sample.txt >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

num=`ls | grep "sample.txt" | wc -l`
comp=`ls | grep "sample.txt.lzo"`

if [ $num -eq 1 ] && [ $comp == sample.txt.lzo ]; then
  check=0
else
  check=1
fi

# Decompress sample.txt.lzo
lzop -dU sample.txt.lzo >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

a=`ls | grep "sample.txt"`
b=`ls | grep "sample.txt" | wc -l`

if [ $b -eq 1 ] && [ $a == sample.txt ]; then
  check=0
else
  check=1
fi

cd ..

# Check result of testcase
assert_passed $check 0

# Remove noneeded files
rm -rf ${PWD}/test_lzop
