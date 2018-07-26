#!/bin/bash

#===============================================================================
# DESCRIPTION: Create sample.txt for testing then compress and decompress using
#              bzip2 command with -z and -d options
#===============================================================================

check=0
echo "Testing bzip2" > ${log_file}
# Create sample.txt file for testing
touch sample.txt 2>> ${log_file}

# Compress file
bzip2 -z sample.txt >> ${log_file} 2>&1
ls sample.txt.bz2 >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Decompress file
bzip2 -d sample.txt.bz2 >> ${log_file} 2>&1
ls sample.txt  >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0

# Remove noneeded file
rm sample.txt
