#!/bin/bash
# author: datnd
#=======================================================
# DESCRIPTION: Testing for creating link file to a file, 
#              checking content of link file,
#              then unlink "newlink"file.
#=======================================================

RESULT=1
EXP_OUTPUT_STEP_2="Hello World"

# run step 1
link  ${data_dir}/file1.txt newlink 2> ${log_file}

# run step 2
OUTPUT_STEP_2=`cat newlink` 2>> ${log_file}
echo -e "OUTPUT_STEP_2:\n""${OUTPUT_STEP_2}" >> ${log_file}
if [ "${OUTPUT_STEP_2}" = "${EXP_OUTPUT_STEP_2}" ]
then
  echo "STEP 2 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 2 FAILED" >> ${log_file}
fi

# run step 3
unlink newlink 2>> ${log_file}
if [ "`ls | grep "newlink"`"  = "" ]
then
  echo "STEP 3 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 3 FAILED" >> ${log_file}
fi

# check result after running all steps
assert_passed ${RESULT} 1
