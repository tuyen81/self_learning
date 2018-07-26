#!/bin/bash

#===============================================================================
# DESCRIPTION: Make partition of storage device and format with xfs format
#              mount storage device with xfs and check device's info
#===============================================================================

. ${CONFIG_DIR}/make_ext3_partition.sh > ${log_file} 2>&1
sleep 4

# Format storage device in "xfs" format
mkfs.xfs -f ${TGTDEV}1 >> ${log_file} 2>&1
sleep 4

# Mount ${TGTDEV}1 to /media
mount -t xfs ${TGTDEV}1 /media/ >> ${log_file} 2>&1

mount | grep "${TGTDEV}1 on /media type xfs" > ${PWD}/output.txt

# Check result of testcase
if [ -s ${PWD}/output.txt ]; then
  echo "${test_passed_text}" >> ${RESULT_FILE}
else
  echo "${test_failed_text}" >> ${RESULT_FILE}
fi

# Delete non-necessary files and restore to default config
rm -fr ${PWD}/output.txt
umount ${TGTDEV}1 >> ${log_file} 2>&1
. ${CONFIG_DIR}/format_partition.sh >> ${log_file} 2>&1
sleep 4
