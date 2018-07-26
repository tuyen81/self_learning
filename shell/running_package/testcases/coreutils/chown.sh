#!/bin/bash

#==============================================================================
# DESCRIPTION: Testing for chown command.
#              The chown command is used to change file owner and group from root to toshiba.
#==============================================================================

check=0
# Create user and group "toshiba"
useradd -U toshiba

cp ${data_dir}/sample_chown.txt ${data_dir}/sample_chown.txt.bak
# Change file owner and group
chown toshiba:toshiba ${data_dir}/sample_chown.txt > ${log_file} 2>&1

if [ -s ${log_file} ]; then
  check=1
fi

ls -l ${data_dir}/sample_chown.txt >> ${log_file} 2>&1

grep -nr toshiba ${log_file} > /dev/null 2>&1

if [ $? != "0" ]; then
  check=1
fi

assert_passed $check 0

mv ${data_dir}/sample_chown.txt.bak ${data_dir}/sample_chown.txt
userdel toshiba
