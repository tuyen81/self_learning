#!/bin/bash
# author: datnd
#=========================================================================================
# DESCRIPTION: Testing for formatting and printing string and fload data by printf command
#=========================================================================================

RESULT=1
EXP_OUTPUT_STEP_1="Hello world"
EXP_OUTPUT_STEP_2="1.0|255.0|123.0|1.2"

# run step 1
OUTPUT_STEP_1=`printf  "%s\n" "Hello world"` 2> ${log_file}
echo -e "OUTPUT_STEP_1:\n""${OUTPUT_STEP_1}" >> ${log_file}
if [ "${OUTPUT_STEP_1}" = "${EXP_OUTPUT_STEP_1}" ]
then
  echo "STEP 1 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 1 FAILED" >> ${log_file}
fi

# run step 2
OUTPUT_STEP_2=`printf "%.1f\n" 1 0xff 0123 1.2` 2>> ${log_file}
echo -e "OUTPUT_STEP_2:\n""${OUTPUT_STEP_2}" >> ${log_file}
if [ -n "`echo "${OUTPUT_STEP_2}" | grep -E "${EXP_OUTPUT_STEP_2}"`" ]
then
  echo "STEP 2 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 2 FAILED" >> ${log_file}
fi

# check result after running all steps
assert_passed ${RESULT} 1
