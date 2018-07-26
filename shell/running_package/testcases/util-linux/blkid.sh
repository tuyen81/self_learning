#!/bin/bash

#===============================================================================
# DESCRIPTION: Make partition for storage device 
#              Run blkid with storage device to determine the type of content
#              storage device  holds
#===============================================================================

. ${CONFIG_DIR}/get_disk.sh > ${log_file} 2>&1
mkdir test; cd test

blkid ${TGTDEV} >> ${log_file} 2>&1

grep "${TGTDEV}:.* PTUUID.* PTTYPE" ${log_file} > ${PWD}/test.txt

# Check result of testcase
if [ -s ${PWD}/test.txt ]; then
  echo "${test_passed_text}" >> ${RESULT_FILE}
else
  echo "${test_failed_text}" >> ${RESULT_FILE}
fi
cd ..

# Delete non-necessary file
rm -fr test
