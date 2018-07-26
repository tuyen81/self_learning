#!/bin/sh
# author: datnd
#=============================================================================
# DESCRIPTION: Testing for determining file type /usr/bin/file by file command
#=============================================================================

EXP_OUTPUT_FILE="/usr/bin/file: ELF "
EXP_OUTPUT_TYPE="\-bit LSB executable"

# run step 1
OUTPUT=`file /usr/bin/file` 2> ${log_file}

echo "OUTPUT:\n""${OUTPUT}" >> ${log_file}

if [ -n "`echo "${OUTPUT}" | grep "${EXP_OUTPUT_FILE}" | grep "${EXP_OUTPUT_TYPE}"`" ]
then
  echo ${test_passed_text} >> ${RESULT_FILE}
else
  echo ${test_failed_text} >> ${RESULT_FILE}
fi
