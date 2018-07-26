#!/bin/bash
# author: datnd
#===================================================================================
# DESCRIPTION: Testing for creating a temporary file and directory by mktemp command
#===================================================================================

RESULT=1
EXP_OUTPUT_STEP_1="/tmp/tmp"
EXP_OUTPUT_STEP_2a="tmp.d"
EXP_OUTPUT_STEP_2b="tmp.d.XXXXXX"

# run step 1
OUTPUT_STEP_1=`mktemp` 2> ${log_file}
echo -e "OUTPUT_STEP_1:\n""${OUTPUT_STEP_1}" >> ${log_file}
if [ -n "`echo "${OUTPUT_STEP_1}" | grep "${EXP_OUTPUT_STEP_1}"`" ]
then
  echo "STEP 1 PASSED" >> ${log_file}
else
  result=0
  echo "STEP 1 FAILED" >> ${log_file}
fi

# run step 2
OUTPUT_STEP_2=`mktemp -d -p . tmp.d.XXXXXX` 2>> ${log_file}
echo -e "OUTPUT_STEP_2:\n""${OUTPUT_STEP_2}" >> ${log_file}
if [ -n "`echo "${OUTPUT_STEP_2}" | grep  "${EXP_OUTPUT_STEP_2a}"`" ]
then
  echo "STEP 2a PASSED" >> ${log_file}
else
  result=0
  echo "STEP 2a FAILED" >> ${log_file}
fi
if [ "`echo "${OUTPUT_STEP_2}" | grep  "${EXP_OUTPUT_STEP_2b}"`" = "" ]
then
  echo "STEP 2b PASSED" >> ${log_file}
else
  result=0
  echo "STEP 2b FAILED" >> ${log_file}
fi

# check result after running all steps
assert_passed ${RESULT} 1

# clean unneeded file after testing
rm -rf tmp.d*
rm -rf /tmp/tmp.*
