#!/bin/bash
# author: datnd
#========================================================
# DESCRIPTION: Testing for creating a symbolic link file,
#              then check content of symbolic link file.
#========================================================

RESULT=1
EXP_OUTPUT_STEP_2="sample_link ->"
EXP_OUTPUT_STEP_3="Hello World"

# run step 1
ln -s  ${data_dir}/sample_original.txt sample_link 2> ${log_file}

# run step 2
OUTPUT_STEP_2=`ls -l sample_link` 2>> ${log_file}
echo -e "OUTPUT_STEP_2:\n""${OUTPUT_STEP_2}" >> ${log_file}
if [ -n "`echo "${OUTPUT_STEP_2}" | grep "${EXP_OUTPUT_STEP_2}"`" ]
then
  echo "STEP 2 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 2 FAILED" >> ${log_file}
fi

# run step 3
OUTPUT_STEP_3=`cat sample_link` 2>> ${log_file}
if [ "${EXP_OUTPUT_STEP_3}" = "${OUTPUT_STEP_3}" ]
then
  echo "STEP 3 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 3 FAILED" >> ${log_file}
fi

# check result after running all steps
assert_passed ${RESULT} 1

# clean unneeded file after testing
rm sample_link
