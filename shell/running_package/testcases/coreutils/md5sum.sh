#!/bin/bash
# author: datnd
#========================================================================================================
# DESCRIPTION: Testing for computing and check MD5 message digest for "sample.txt" file by md5sum command
#========================================================================================================

EXP_OUTPUT="f0ef7081e1539ac00ef5b761b4fb01b3"

# run step 1
OUTPUT_STEP_1=`md5sum  ${data_dir}/sample.txt` 2> ${log_file}

echo -e "OUTPUT_STEP_1:\n""${OUTPUT_STEP_1}" >> ${log_file}

if [ -n "`echo "${OUTPUT_STEP_1}" | grep "${EXP_OUTPUT}"`" ]
then
  echo "STEP 1 PASSED" >> ${log_file}
  echo ${test_passed_text} >> ${RESULT_FILE}
else
  echo "STEP 1 FAILED" >> ${log_file}
  echo ${test_failed_text} >> ${RESULT_FILE}
fi
