#!/bin/bash

#==============================================================================
# DESCRIPTION: Copy /dev/zero to driveimage.dd with hashwindow=20k then
#              Check content of output file
#==============================================================================

check=0

echo "Testing dcfldd" > ${log_file} 2>&1

# Convert and copy file
dcfldd if=/dev/zero hash=md5,sha256 hashwindow=20k md5log=md5.txt sha256log=sha256.txt hashconv=after bs=1k count=100 conv=noerror of=driveimage.dd &>> ${log_file}

if [ $? -ne 0 ]; then
  check=1
fi

(grep "100+0 records in" ${log_file} &> /dev/null)&&(grep "100+0 records out" ${log_file} &> /dev/null) &> /dev/null

if [ $? -ne 0 ]; then
  check=1
fi

# Check files which created
ls -lh ${PWD}/driveimage.dd | grep "\-rw\-r\-\-r\-\- 1 root root 100K" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check content of md5.txt and sha256.txt
diff ${PWD}/md5.txt ${data_dir}/md5 >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

diff ${PWD}/sha256.txt ${data_dir}/sha256 >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0

# Remove noneeded file
rm ${PWD}/driveimage.dd ${PWD}/sha256.txt ${PWD}/md5.txt
