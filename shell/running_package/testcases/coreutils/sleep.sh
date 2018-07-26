#!/bin/bash
#==============================================================================
# DISCRIPTION: Test script is test to 'sleep' command.
#              The 'sleep' command use to pauses system for an amount two seconds
#              The actual output is compared with expected output to give result.
#==============================================================================

# Run sleep command pauses for an amount two seconds
{ time sleep 2 ; } 2> ${log_file}

# Check result of command sleep with expected output
if [ -n "`cat ${log_file} | grep "real"` && `cat ${log_file} | grep "user"` && `cat ${log_file} | grep "sys"`" ]
then
  echo "${test_passed_text}" >> ${RESULT_FILE}
else
  echo "${test_failed_text}" >> ${RESULT_FILE}
fi
