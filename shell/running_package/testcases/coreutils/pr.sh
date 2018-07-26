#!/bin/bash
# author: datnd
#=================================================================================================================
# DESCRIPTION: Testing for converting text files for printing by pr command,
#              input is created by dmesg command.
#=================================================================================================================

EXP_OUTPUT_STEP_1="Kernel message|Page"

# run step 1
OUTPUT_STEP_1=`dmesg | pr  -l 15 -n -h "Kernel message" | less` 2> ${log_file}

echo -e "OUTPUT_STEP_1:\n""${OUTPUT_STEP_1}" >> ${log_file}

if [ -n "`echo "${OUTPUT_STEP_1}" | grep -E "${EXP_OUTPUT_STEP_1}"`" ]
then
  echo "STEP 1 PASSED" >> ${log_file}
  echo ${test_passed_text} >> ${RESULT_FILE}
else
  echo "STEP 1 FAILED" >> ${log_file}
  echo ${test_failed_text} >> ${RESULT_FILE}
fi
