#!/bin/bash
#==============================================================================
# DISCRIPTION: Test script is test to 'truncate' command.
#              In test script 'truncate' command used to extend size of
#              a sample.txt file from 0 byte to 50 byte
#==============================================================================

# Size expected output
EXPECTED_SIZE=" root root 50 "

# Create a sample.txt file with size is 0 byte
mkdir -p ${data_dir}
cat /dev/null > ${data_dir}/sample.txt

# Extend size of file sample.txt
truncate --size 50 ${data_dir}/sample.txt > ${log_file} 2>&1

if [ $? = "0" ]; then
  # Check size of sample.txt file after extend size
  ls -l ${data_dir}/sample.txt >> ${log_file} 2>&1
fi

# Check result of command truncate with expected output
if [ -n "`cat ${log_file} | grep "${EXPECTED_SIZE}"`" ]
then
  echo "${test_passed_text}" >> ${RESULT_FILE}
else
  echo "${test_failed_text}" >> ${RESULT_FILE}
fi

# Remove a directory and sample.txt file temp for testing
rm -rf ${data_dir}
