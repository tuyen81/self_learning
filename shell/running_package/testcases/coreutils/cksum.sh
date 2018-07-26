#!/bin/bash
# author: datnd
#============================================================================
# DESCRIPTION: Testing for checksum and counting the bytes in sample.txt file
#============================================================================

RESULT=1
EXP_OUTPUT_STEP_1="083891038"

# run step 1
OUTPUT_STEP_1=`cksum ${data_dir}/sample.txt` 2> ${log_file}
echo -e "OUTPUT_STEP_1:\n""${OUTPUT_STEP_1}" >> ${log_file}
if [ -n "`echo "${OUTPUT_STEP_1}" | grep -E "${EXP_OUTPUT_STEP_1}"`" ]
then
  echo "STEP 1 PASSED" >> ${log_file}
  echo ${test_passed_text} >> ${RESULT_FILE}
else
  echo "STEP 1 FAILED" >> ${log_file}
  echo ${test_failed_text} >> ${RESULT_FILE}
fi
