#!/bin/bash
#==============================================================================
# DISCRIPTION: Test script is test to 'wc' command.
#              The 'wc' command used to word count in sample.txt file
#              The sample.txt file has been stored contents 'Word 1\n Word 2\n to Word 5'.
#==============================================================================

# Declare expected output number word count in sample.txt file
EXPECTED_OUTPUT="5"

# Run "wc" command to word count in sample.txt file
wc ${data_dir}/sample.txt > ${log_file} 2>&1

# Check result of command wc with expected output
if [ -n "`cat ${log_file} | grep "${EXPECTED_OUTPUT}"`" ]
then
  echo "${test_passed_text}" >> ${RESULT_FILE}
else
  echo "${test_failed_text}" >> ${RESULT_FILE}
fi
