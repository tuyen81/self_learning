#!/bin/sh
# author: datnd
#===============================================================================
# DESCRIPTION: Testing for finding a file in a directory by find commnad
#              Executing ls command from standar input by xargs commnad
#              Listing files in database that match "bin/find" by locate command
#===============================================================================

RESULT=1
EXP_OUTPUT_STEP_1="/usr/bin/find"
EXP_OUTPUT_STEP_2="boot"

# run step 1
OUTPUT_STEP_1=`find /usr -name find` 2> ${log_file}
echo "OUTPUT_STEP_1:\n""${OUTPUT_STEP_1}" >> ${log_file}
if [ -n "`echo "${OUTPUT_STEP_1}" | grep "${EXP_OUTPUT_STEP_1}"`" ]
then
  echo "STEP 1 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 1 FAILED" >> ${log_file}
fi
# run step 2
OUTPUT_STEP_2=`echo "/" | xargs ls` 2>> ${log_file}
echo "OUTPUT_STEP_2:\n""${OUTPUT_STEP_2}" >> ${log_file}
if [ -n "`echo "${OUTPUT_STEP_2}" | grep "${EXP_OUTPUT_STEP_2}"`" ]
then
  echo "STEP 2 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 2 FAILED" >> ${log_file}
fi

# check result after running all steps
assert_passed ${RESULT} 1
