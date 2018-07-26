#!/bin/bash
#==============================================================================
# DISCRIPTION: Test script is test to 'true' command.
#              In test script 'true' command exit with a status code indicating
#              success when use 'ls' command to check not exist directory
#==============================================================================

# Declare expected result
EXPECTED_RESULT="0"

# "true" command exit with a status code indicating success when check not exist directory
true  ls /not_exist_dir > ${log_file} 2>&1

echo $? >> ${log_file} 2>&1

# Check result of command true with expected output
if [ -n "`cat ${log_file} | grep "${EXPECTED_RESULT}"`" ]
then
  echo "${test_passed_text}" >> ${RESULT_FILE}
else
  echo "${test_failed_text}" >> ${RESULT_FILE}
fi
