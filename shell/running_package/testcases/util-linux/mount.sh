#!/bin/bash

#===============================================================================
# DESCRIPTION: Make partition for storage device
#              mount storage device to directory, check mount point and unmount 
#              using mount and umount
#===============================================================================

mkdir test; cd test
. ${CONFIG_DIR}/make_ext3_partition.sh > ${log_file} 2>&1
sleep 4
# Create folder to mount
mkdir -p sample.d >> ${log_file} 2>&1
mount ${TGTDEV}1 sample.d >> ${log_file} 2>&1

# Check mount point
mount > ${PWD}/output.txt
grep "${TGTDEV}1 on " ${PWD}/output.txt > ${PWD}/test.txt

# Check result of testcase
if [ -s ${PWD}/test.txt ]; then
  echo "${test_passed_text}" >> ${RESULT_FILE}
else
  echo "${test_failed_text}" >> ${RESULT_FILE}
fi
cd ..

# Delete non-necessary file, unmount and format storage device
umount ${TGTDEV}1 >> ${log_file} 2>&1
. ${CONFIG_DIR}/format_partition.sh >> ${log_file} 2>&1
sleep 4
rm -fr test
