#!/bin/sh
# author: datnd
#====================================================================
# DESCRIPTION: Test for the compressing and expanding by gzip command
#====================================================================

RESULT=1
EXP_OUTPUT_STEP_1="sample.txt.gz"
EXP_OUTPUT_STEP_2="sample.txt"

touch sample.txt

# run step 1
gzip sample.txt 2> ${log_file}

OUTPUT_STEP_1=`ls` 2> ${log_file}

echo "OUTPUT_STEP_1:\n""${OUTPUT_STEP_1}" >> ${log_file}
if [ -n "`echo "${OUTPUT_STEP_1}" | grep "${EXP_OUTPUT_STEP_1}"`" ]
then
  echo "STEP 1 PASSED" >> ${log_file}
else    
  RESULT=0
  echo "STEP 1 FAILED" >> ${log_file}
fi

# run step 2
gzip -d sample.txt.gz 2> ${log_file}

OUTPUT_STEP_2=`ls` 2> ${log_file}

echo "OUTPUT_STEP_2:\n""${OUTPUT_STEP_2}" >> ${log_file}

if [ -n "`echo "${OUTPUT_STEP_2}" | grep "${EXP_OUTPUT_STEP_2}"`" ]
then
  echo "STEP 2 PASSED" >> ${log_file}
  rm ${EXP_OUTPUT_STEP_2}
else
  RESULT=0
  echo "STEP 2 FAILED" >> ${log_file}
fi

# check result after running all steps
assert_passed ${RESULT} 1
