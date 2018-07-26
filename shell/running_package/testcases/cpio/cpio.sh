#!/bin/bash

#===============================================================================
# DESCRIPTION: Create 2 temp files then create an archive file include 2 temp file
#              Extract archived file to 2 temp file
#===============================================================================

check=0
echo "Testing cpio" > ${log_file}

# Create files for testing
mkdir -p ${PWD}/test_cpio >> ${log_file} 2>&1
cd ${PWD}/test_cpio
touch tmp1.txt tmp2.txt >> ${log_file} 2>&1

# Create the archive file
{ ls | cpio -o > tmp.cpio; } >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

ls | grep "tmp.cpio" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Extract the archived file
rm tmp1.txt tmp2.txt >> ${log_file} 2>&1

cpio -i < tmp.cpio >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

count=`ls | grep "tmp[0-9].txt" | wc -l`

if [ $count -ne 2 ]; then
  check=1
fi

cd ..

# Check result of testcase
assert_passed $check 0

# Remove noneeded files
rm -rf ${PWD}/test_cpio
