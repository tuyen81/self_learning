#!/bin/bash

#===============================================================================
# DESCRIPTION: This testcase create .deb file from hello_1.0,
#              show package control information and package content.
#===============================================================================

check=0
echo "Testing dpkg" > ${log_file}

# Create file and directory for testing
mkdir -p ${PWD}/test_dpkg >> ${log_file} 2>&1
cd ${PWD}/test_dpkg
cp -r ${data_dir}/hello_1.0 . >> ${log_file} 2>&1

# Create .deb file
dpkg --build hello_1.0 >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

ls | grep "hello_1.0.deb" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Show package control information
dpkg -I hello_1.0.deb | grep "Description: Test dpkg" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Show package contents
dpkg -c hello_1.0.deb | grep "/usr/bin/hello" | grep "\-rw\-r\-\-r\-\-" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

cd ..

# Check result of testcase
assert_passed $check 0

# Remove noneeded files
rm -rf ${PWD}/test_dpkg
