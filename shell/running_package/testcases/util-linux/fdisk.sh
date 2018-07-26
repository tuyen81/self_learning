#!/bin/bash

#===============================================================================
# DESCRIPTION: Delete and make partition for storage device using fdisk command
#              list disk info by using -l option of fdisk command
#===============================================================================

. ${CONFIG_DIR}/get_disk.sh > ${log_file} 2>&1

sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk ${TGTDEV} >> ${log_file} 2>&1
  n # new partition
  p # primary partition
  1 # partition number 1
    # default - start at beginning of disk
  +100M # 100 MB boot parttion
  p # print the in-memory partition table
  w # write the partition table
EOF
# Check result of testcase
assert_passed $? 0

# Delete non-necessary file and format storage device
. ${CONFIG_DIR}/format_partition.sh >> ${log_file} 2>&1
