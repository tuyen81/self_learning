#!/bin/bash
# author: datnd
#=======================================================================
# DESCRIPTION: Testing for printing a sequence of numbers by seq command
#=======================================================================

EXP_OUTPUT_STEP_1="line1|line3|line5|line7|line9"

# run step 1
OUTPUT_STEP_1=`seq  -f "line%g" 1 2 10`

echo -e "OUTPUT_STEP_1:\n""${OUTPUT_STEP_1}" > ${log_file}
if [ -n "`echo "${OUTPUT_STEP_1}" | grep -E "${EXP_OUTPUT_STEP_1}"`" ]
then
  echo "STEP 1 PASSED" >> ${log_file}
  echo ${test_passed_text} >> ${RESULT_FILE}
else
  echo "STEP 1 FAILED" >> ${log_file}
  echo ${test_failed_text} >> ${RESULT_FILE}
fi
