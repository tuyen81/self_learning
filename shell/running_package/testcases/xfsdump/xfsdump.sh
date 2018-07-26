#!/bin/bash

#===============================================================================
# DESCRIPTION: Make partition of storage device and format with xfs format
#              mount storage device with xfs and check device's info
#===============================================================================

check=0
echo "Testing xfsdumps" > ${log_file}

. ${CONFIG_DIR}/make_ext3_partition.sh >> ${log_file} 2>&1
sleep 4

# Format storage device in "xfs" format
mkfs.xfs -f ${TGTDEV}1 >> ${log_file} 2>&1
sleep 4

# Mount ${TGTDEV}1 to /media
mount -t xfs ${TGTDEV}1 /media/ >> ${log_file} 2>&1

mount | grep "${TGTDEV}1 on /media type xfs" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Create a file in /media for testing
touch /media/file1.txt 2>> ${log_file}

# Check result of testcase
assert_passed $check 0

# Delete non-necessary files and restore to default config
rm -fr ${PWD}/output.txt
umount ${TGTDEV}1 >> ${log_file} 2>&1
. ${CONFIG_DIR}/format_partition.sh >> ${log_file} 2>&1
sleep 4
