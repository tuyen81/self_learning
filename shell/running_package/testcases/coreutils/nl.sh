#!/bin/bash
# author: datnd
#=========================================================================
# DESCRIPTION: Testign for the showing number lines of file by nl command
#=========================================================================

EXP_OUTPUT_STEP_1="10	line10"

# run step 1
OUTPUT_STEP_1=`nl  ${data_dir}/sample.txt` 2> ${log_file}

echo -e "OUTPUT_STEP_1:\n""${OUTPUT_STEP_1}" >> ${log_file}

if [ -n "`echo "${OUTPUT_STEP_1}" | grep "${EXP_OUTPUT_STEP_1}"`" ]
then
  echo "STEP 1 PASSED" >> ${log_file}
  echo ${test_passed_text} >> ${RESULT_FILE}
else
  echo "STEP 1 FAILED" >> ${log_file}
  echo ${test_failed_text} >> ${RESULT_FILE}
fi
