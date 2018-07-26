#!/bin/bash
#==============================================================================
# DISCRIPTION: Test script is test to 'test' command.
#              In test script use 'test' command to evaluates the expression
#              parameter '100 -lt 99'.
#==============================================================================

EXPECTED_OUTPUT="No."

# use "test" command to evaluates the expression parameter "100 -lt 99"
test  100 -lt 99 && echo "Yes." || echo "No." > ${log_file} 2>&1

# Check result of command test with expected output
if [ -n "`cat ${log_file} | grep "${EXPECTED_OUTPUT}"`" ]
then
  echo "${test_passed_text}" >> ${RESULT_FILE}
else
  echo "${test_failed_text}" >> ${RESULT_FILE}
fi
