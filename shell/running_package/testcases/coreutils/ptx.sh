#!/bin/bash
# author: datnd
#====================================================================================
# DESCRIPTION: Testing for producing a permuted index of file contents by ptx command
#====================================================================================

EXP_OUTPUT="\xx {}{H}{e}{ l l o}{}"

# run step 1
OUTPUT_STEP_1=`echo "H e l l o" | ptx -T` 2> ${log_file}

echo -e "OUTPUT_STEP_1:\n""${OUTPUT_STEP_1}" >> ${log_file}

if [ -n "`echo "${OUTPUT_STEP_1}" | grep "${EXP_OUTPUT}"`" ]
then
  echo "STEP 1 PASSED" >> ${log_file}
  echo ${test_passed_text} >> ${RESULT_FILE}
else
  echo "STEP 1 FAILED" >> ${log_file}
  echo ${test_failed_text} >> ${RESULT_FILE}
fi
