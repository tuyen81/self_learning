#!/bin/bash
# author: datnd
#===============================================================
# DESCRIPTION: Testing for moving file and folder by  mv command
#===============================================================

RESULT=1
EXP_OUTPUT_STEP_1="sample.txt"
EXP_OUTPUT_STEP_2="newname.txt"

#prepare for testing
mkdir -p ${OUTPUT_DIR}/${PN}/tmp
mkdir -p ${OUTPUT_DIR}/${PN}/tmp/sample.d
touch ${OUTPUT_DIR}/${PN}/tmp/sample.txt

# run step 1
mv ${OUTPUT_DIR}/${PN}/tmp/sample.txt ${OUTPUT_DIR}/${PN}/tmp/sample.d 2> ${log_file}
OUTPUT_STEP_1=`ls ${OUTPUT_DIR}/${PN}/tmp/sample.d` 2> ${log_file}
echo -e "OUTPUT_STEP_1:\n""${OUTPUT_STEP_1}" >> ${log_file}
if [ "${OUTPUT_STEP_1}" = "${EXP_OUTPUT_STEP_1}" ]
then
  echo "STEP 1 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 1 FAILED" >> ${log_file}
fi

# run step 2
mv ${OUTPUT_DIR}/${PN}/tmp/sample.d/sample.txt ${OUTPUT_DIR}/${PN}/tmp/sample.d/newname.txt
OUTPUT_STEP_2=`ls ${OUTPUT_DIR}/${PN}/tmp/sample.d` 2>> ${log_file}
echo -e "OUTPUT_STEP_2:\n""${OUTPUT_STEP_2}" >> ${log_file}
if [ "${OUTPUT_STEP_2}" = "${EXP_OUTPUT_STEP_2}" ]
then
  echo "STEP 2 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 2 FAILED" >> ${log_file}
fi

# check result after running all steps
assert_passed ${RESULT} 1

# clean unneeded output after testing
rm -rf ${OUTPUT_DIR}/${PN}/tmp/
