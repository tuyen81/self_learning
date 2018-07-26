#!/bin/bash
#==============================================================================
# DISCRIPTION: Test script is test to 'sum' command.
#              The 'sum' command is uses two different algorithms for
#              calculating the checksum of sample.txt file. The sample.txt file
#              has been stored contents 'Hello world'.
#==============================================================================

CHECKSUM="45745"

# Calculating the checksum of sample.txt file stored contents "Hello world" by "sum" command
sum ${data_dir}/sample.txt > ${log_file} 2>&1

# Check result of command sum with expected output
if [ -n "`cat ${log_file} | grep "${CHECKSUM}"`" ]
then
  echo "${test_passed_text}" >> ${RESULT_FILE}
else
  echo "${test_failed_text}" >> ${RESULT_FILE}
fi
