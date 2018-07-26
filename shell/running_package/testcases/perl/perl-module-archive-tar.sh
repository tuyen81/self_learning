#!/bin/bash

#==============================================================================
# DESCRIPTION: Run sample.pl file using perl command
#              After run script, file1 and file2 was extracted from .tgz file
#==============================================================================

echo "Testing perl-module-archive-tar" > ${log_file}

check=0
# Create a directory with some files and compress it
mkdir dir; touch dir/file1 dir/file2 >> ${log_file} 2>&1
tar --remove-files -czf dir.tgz dir >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Run perl script using perl
perl ${data_dir}/sample.pl >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Get created file info
ls dir | grep "file1" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

ls dir | grep "file2" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0

# Remove noneeded files
rm -rf dir dir.tgz
