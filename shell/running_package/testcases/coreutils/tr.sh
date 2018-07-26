#!/bin/bash
#==============================================================================
# DISCRIPTION: Test script is test to 'tr' command.
#              In test script 'tr' command used to replacing and removing
#              specific characters in it's input data set.
#==============================================================================

# Declare expected output
EXPECTED_STRING_ECHO1="HELLO, I AM TRANSLTR"
EXPECTED_STRING_ECHO2="Hello,_I_am_TRANSLTR_Hello"
EXPECTED_STRING_ECHO3="I am RANSLR"

# Use "tr" command to replacing and removing specific characters in its input data set
echo "Hello, I am TRANSLTR" | tr  a-z A-Z > ${log_file} 2>&1
echo "Hello, I am TRANSLTR" | tr  [:space:] '_' >>${log_file} 2>&1
echo "Hello, I am TRANSLTR" | tr  -d 'T' >> ${log_file} 2>&1

# Check result of command tr with expected output
if [ -n "`cat ${log_file} | grep "${EXPECTED_STRING_ECHO1}"` && `cat ${log_file} | grep "${EXPECTED_STRING_ECHO2}"` && `cat ${log_file} | grep "${EXPECTED_STRING_ECHO3}"`" ]
then
  echo "${test_passed_text}" >> ${RESULT_FILE}
else
  echo "${test_failed_text}" >> ${RESULT_FILE}
fi
