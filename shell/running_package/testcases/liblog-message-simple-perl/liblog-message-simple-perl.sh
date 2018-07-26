#!/bin/bash

#==============================================================================
# DESCRIPTION: Create sample.pl use Log::Message::Simple perl module
#              Using perl command to run sample.pl file and check log msg function
#==============================================================================

echo "Testing perl-module-log-message-simple" > ${log_file}
check=0

# Create file and directory for testing
cp -r ${data_dir} ${PWD}/test_perl_module >> ${log_file} 2>&1
cd ${PWD}/test_perl_module

# Run sample.pl file using perl command and check function of msg log
perl sample.pl >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

grep '\[MSG\] Function msg' ${log_file} > /dev/null 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

cd ..

# Check result of testcase
assert_passed $check 0

# Remove noneeded files
rm -rf ${PWD}/test_perl_module
