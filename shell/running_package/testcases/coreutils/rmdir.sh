#!/bin/bash
# author: datnd
#===============================================================================================================
# DESCRIPTION: Testing removing directory by rmdir command when whether there is a file in the directory or not,
#              if yes then can not remove folder, if no then folder is removed.
#===============================================================================================================

RESULT=1
EXP_OUTPUT_STEP_2="failed to remove"
EXP_OUTPUT_STEP_3="sample.d"

# run step 1
mkdir sample.d
touch sample.d/file{1..10}

# run step 2
echo "OUTPUT_STEP_2:\n" > ${log_file}
rmdir sample.d/ > ${log_file} 2>&1
if [ -n "`cat ${log_file} | grep "${EXP_OUTPUT_STEP_2}"`" ]
then
  echo "STEP 2 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 2 FAILED" >> ${log_file}
fi

# run step 3
rm sample.d/*
rmdir  sample.d/ >> ${log_file} 2>&1
OUTPUT_STEP_3=`ls`
if [ "`echo "${OUTPUT_STEP_3}" | grep "${EXP_OUTPUT_STEP_3}"`" = "" ]
then
  echo "STEP 3 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 3 FAILED" >> ${log_file}
fi

# check result after running all steps
assert_passed ${RESULT} 1
