#!/bin/bash
# author: datnd
#==============================================================
# DESCRIPTION: Testing for creating new folder by mkdir command
#==============================================================

EXP_OUTPUT_STEP_2="child_dir"

# run step 1
mkdir -p /root/parent_dir/child_dir 2> ${log_file}

# run step 2
OUTPUT_STEP_2=`ls -l /root/parent_dir` 2>> ${log_file}

echo -e "OUTPUT_STEP_2:\n""${OUTPUT_STEP_2}" >> ${log_file}

if [ -n "`echo "${OUTPUT_STEP_2}" | grep "${EXP_OUTPUT_STEP_2}"`" ]
then
  echo "STEP 2 PASSED" >> ${log_file}
  echo ${test_passed_text} >> ${RESULT_FILE}  
else
  echo "STEP 2 FAILED" >> ${log_file}
  echo ${test_failed_text} >> ${RESULT_FILE}
fi

# clean unneeded file after testing
rm -rf /root/parent_dir/child_dir
