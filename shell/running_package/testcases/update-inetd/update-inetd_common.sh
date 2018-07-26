#!/bin/bash

#===============================================================================
# DESCRIPTION: Create a config file, then using update-inetd command to add,
#              remove, modify content of file
#===============================================================================

check=0
echo "Testing update-inetd" > ${log_file}

# Create config file for testing
touch ${PWD}/sample.conf >> ${log_file} 2>&1

# Add new service
update-inetd --file ${PWD}/sample.conf --add 'pop-3\t\tstream\ttcp\tnowait\troot\t/usr/sbin/tcpd\t/usr/sbin/in.pop3d' >> ${log_file} 2>&1

grep "^pop-3" ${PWD}/sample.conf >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Disable service
update-inetd --file ${PWD}/sample.conf --comment-chars '#' --disable pop-3

grep "^#pop-3" ${PWD}/sample.conf >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Enable service
update-inetd --file ${PWD}/sample.conf --comment-chars '#' --enable pop-3

grep "^pop-3" ${PWD}/sample.conf >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Remove service
update-inetd --file ${PWD}/sample.conf --remove pop-3

grep "pop-3" ${PWD}/sample.conf >> ${log_file} 2>&1

if [ $? -eq 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0

# Remove noneeded files
rm ${PWD}/sample.conf
