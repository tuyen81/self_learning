#!/bin/bash
# author: datnd
#===============================================================================
# DESCRIPTION: Testing for showing the values of environment and PATH variables.
#===============================================================================

RESULT=1
EXP_OUTPUT_STEP_1="SHELL="
EXP_OUTPUT_STEP_2="/bin"

# run step 1
OUTPUT_STEP_1=`printenv` 2> ${log_file}
echo -e "OUTPUT_STEP_1:\n""${OUTPUT_STEP_1}" >> ${log_file}
if [ -n "`echo "${OUTPUT_STEP_1}" | grep "${EXP_OUTPUT_STEP_1}"`" ]
then
  echo "STEP 1 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 1 FAILED" >> ${log_file}
fi

# run step 2
OUTPUT_STEP_2=`printenv PATH` 2>> ${log_file}
echo -e "OUTPUT_STEP_2:\n""${OUTPUT_STEP_2}" >> ${log_file}
if [ -n "`echo "${OUTPUT_STEP_2}" | grep "${EXP_OUTPUT_STEP_2}"`" ]
then
  echo "STEP 2 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 2 FAILED" >> ${log_file}
fi

# check result after running all steps
assert_passed ${RESULT} 1
