#!/bin/bash

#===============================================================================
# DESCRIPTION: Make partition for storage device
#              Display list the partition and  size of a partition storage device
#===============================================================================

. ${CONFIG_DIR}/get_disk.sh > ${log_file} 2>&1
mkdir test; cd test

sfdisk -s >> ${log_file} 2>&1

grep "${TGTDEV}:" ${log_file} > ${PWD}/test.txt

# Check result of testcase
if [ -s ${PWD}/test.txt ]; then
  echo "${test_passed_text}" >> ${RESULT_FILE}
else
  echo "${test_failed_text}" >> ${RESULT_FILE}
fi
cd ..

# Delete non-necessary file
rm -fr test
