#!/bin/bash
# author: datnd
#=================================================================================
# DESCRIPTION: Testing for comparing two sorted files line by line by comm command
#=================================================================================

RESULT=1
EXP_OUTPUT_STEP_1="2*3"
EXP_OUTPUT_STEP_2="1*4"

echo -e "1\n2\n3" > tmp_sample1.txt
echo -e "2\n3\n4" > tmp_sample2.txt

# run step 1
OUTPUT_STEP_1=`comm -12 tmp_sample1.txt tmp_sample2.txt` 2> ${log_file}
echo -e "OUTPUT_STEP_1:\n""${OUTPUT_STEP_1}" >> ${log_file}
if [ -n "`echo "${OUTPUT_STEP_1}" | grep -E "${EXP_OUTPUT_STEP_1}"`" ]
then
  echo "STEP 1 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 1 FAILED" >> ${log_file}
fi
# run step 2
OUTPUT_STEP_2=`comm -3 tmp_sample1.txt tmp_sample2.txt` 2>> ${log_file}
echo -e "OUTPUT_STEP_2:\n""${OUTPUT_STEP_2}" >> ${log_file}
if [ -n "`echo "${OUTPUT_STEP_2}" | grep -E "${EXP_OUTPUT_STEP_2}"`" ]
then
  echo "STEP 2 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 2 FAILED" >> ${log_file}
fi

# check result after running all steps
assert_passed ${RESULT} 1

# Remove non-necessary files
rm -r tmp_sample1.txt tmp_sample2.txt
