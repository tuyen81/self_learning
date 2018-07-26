#!/bin/bash

#==============================================================================
# DESCRIPTION: Run sample.pl file using perl command
#              Script create a file with 644 permission and display fixed date time
#==============================================================================

echo "Testing perl-module-posix" > ${log_file}

check=0
# Run perl script using perl
perl ${data_dir}/sample.pl | grep "Date = Fri Jul 15 16:30:22 2016" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Get created file info
ls -l file | sed 's/ .* //g' | grep "\-rw\-r\-\-r\-\-file" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0

# Remove noneeded file
rm file
