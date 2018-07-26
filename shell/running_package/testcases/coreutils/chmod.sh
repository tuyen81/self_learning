#!/bin/bash

#==============================================================================
# DESCRIPTION: Testing for chmod command.
#              The chmod command is used to change the permissions of a file.
#              The first, set permission 664 for a file and then add write permission for other user.
#==============================================================================

check=0

cp ${data_dir}/sample_chmod.txt ${data_dir}/sample_chmod.txt.bak
# Set permission 664 for file sample_chmod.txt
chmod 664 ${data_dir}/sample_chmod.txt > ${log_file} 2>&1

if [ -s ${log_file} ]; then
  check=1
fi

# Check file's permission
ls -l ${data_dir}/sample_chmod.txt >> ${log_file} 2>&1

grep -nr "\-rw\-rw\-r\-\-" ${log_file} > /dev/null 2>&1

if [ $? != "0" ]; then
  check=1
fi

# Add write permission for other user
chmod o+w ${data_dir}/sample_chmod.txt >> ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

# Check file's permission
ls -l ${data_dir}/sample_chmod.txt >> ${log_file} 2>&1

grep -nr "\-rw\-rw\-rw\-" ${log_file} > /dev/null 2>&1

if [ $? != "0" ]; then
  check=1
fi

assert_passed $check 0

mv ${data_dir}/sample_chmod.txt.bak ${data_dir}/sample_chmod.txt
