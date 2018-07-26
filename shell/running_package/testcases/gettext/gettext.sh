#!/bin/sh
# author: datnd
#===============================================================
# DESCRIPTION: Testing for the combining message from two files 
#              and then write output to a file by msgcat command 
#===============================================================

EXP_OUTPUT_STEP_2="Report bugs to"

# run step 1
msgcat -o compendium.po ${data_dir}/file1.po ${data_dir}/file2.po

# run step 2
OUTPUT_STEP_2=`cat compendium.po` 2> ${log_file}

echo "OUTPUT_STEP_2:\n""${OUTPUT_STEP_2}" >> ${log_file}

if [ -n "`echo "${OUTPUT_STEP_2}" | grep "${EXP_OUTPUT_STEP_2}"`" ]
then
  echo "STEP 2 PASSED" >> ${log_file}
  echo ${test_passed_text} >> ${RESULT_FILE}
else
  echo "STEP 2 FAILED" >> ${log_file}
  echo ${test_failed_text} >> ${RESULT_FILE}  
fi

# clean unneeded output
rm compendium.po 
