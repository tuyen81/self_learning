#!/bin/bash
# author: datnd
#==========================================================================
# DESCRIPTION: Testing for making character file '/devfb0' by mknod command,
#              then check attributes of '/devfb0' file.
#=========================================================================

EXP_OUTPUT_STEP_2="29, 0"

# run step 1
mknod /dev/fb0 c 29 0 2> ${log_file}

# run step 2
OUTPUT_STEP_2=`ls -l /dev/fb0` 2>> ${log_file}

echo -e "OUTPUT_STEP_2:\n""${OUTPUT_STEP_2}" >> ${log_file}

if [ -n "`echo "${OUTPUT_STEP_2}" | grep "/dev/fb0" | grep "${EXP_OUTPUT_STEP_2}"`" ]
then
  echo "STEP 2 PASSED" >> ${log_file}
  echo ${test_passed_text} >> ${RESULT_FILE}
else
  echo "STEP 2 FAILED" >> ${log_file}
  echo ${test_failed_text} >> ${RESULT_FILE}
fi

# clean unneeded file after testing
rm /dev/fb0 >> ${log_file} 2>&1
