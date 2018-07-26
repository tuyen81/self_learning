#!/bin/sh
# author: datnd
#=======================================================================
# DESCRIPTION: Test for the finding text base on pattern by grep command
#=======================================================================

EXP_OUTPUT_STEP_1="grep"

# run test
OUTPUT_STEP_1=`ls /usr/bin | grep "grep"` 2> ${log_file}

echo "OUTPUT_STEP_1:\n""${OUTPUT_STEP_1}" >> ${log_file}

if [ -n "`echo "${OUTPUT_STEP_1}" | grep "${EXP_OUTPUT_STEP_1}"`" ]
then
  echo "STEP 1 PASSED" >> ${log_file}
  echo ${test_passed_text} >> ${RESULT_FILE}
else
  echo "STEP 1 FAILED" >> ${log_file}
  echo ${test_failed_text} >> ${RESULT_FILE}
fi
