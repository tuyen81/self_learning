#!/bin/sh
# author: datnd
#=============================================================================
# DESCRIPTION: Test for generating programs from sample.y file by flex command
#=============================================================================

EXP_OUTPUT_STEP_2="lex.yy.c"

# run step 1
flex ${data_dir}/sample.y
# run step 2
OUTPUT_STEP_2=`ls` 2>  ${log_file}

echo "OUTPUT_STEP_2:\n""${OUTPUT_STEP_2}" >> ${log_file}

if [ -n "`echo "${OUTPUT_STEP_2}" | grep "${EXP_OUTPUT_STEP_2}"`" ]
then
  echo "STEP 2 PASSED" >> ${log_file}
  echo ${test_passed_text} >> ${RESULT_FILE}
else
  echo "STEP 2 FAILED" >> ${log_file}
  echo ${test_failed_text} >> ${RESULT_FILE}
fi

# clean after testing
rm lex.yy.c
