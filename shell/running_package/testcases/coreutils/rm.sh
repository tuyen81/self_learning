#!/bin/bash
# author: datnd
#================================================================
# DESCRIPTION: Testing for removing file sample.txt by rm command
#================================================================

# run step 1
touch sample.txt

# run step 2
rm -rf sample.txt 2> ${log_file}

OUTPUT_STEP=`ls`

echo -e "OUTPUT_STEP:\n""${OUTPUT_STEP}" >> ${log_file}

if [ "`echo "${OUTPUT_STEP}" | grep "sample.txt"`" = "" ]
then
  echo "STEP 1 PASSED" >> ${log_file}
  echo ${test_passed_text} >> ${RESULT_FILE}
else
  echo "STEP 1 FAILED" >> ${log_file}
  echo ${test_failed_text} >> ${RESULT_FILE}
fi
