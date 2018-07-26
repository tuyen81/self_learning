#!/bin/bash

#==============================================================================
# DESCRIPTION: Testing for getfacl command.
#              The first, mount a partition with 'acl' option to /mnt mount point
#              then get acl of /mnt/root directory.
#==============================================================================

. ${CONFIG_DIR}/get_disk.sh > ${log_file} 2>&1
mkdir -p /mnt > /dev/null 2>&1

# Mount ${FILE_SYSTEM_PARTITION} with "acl" option
mount -o acl ${FILE_SYSTEM_PARTITION} /mnt >> ${log_file} 2>&1

check=0
getfacl /mnt/root >> ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

grep -nr user ${log_file} > /dev/null 2>&1
if [ $? != "0" ]; then
  check=1
fi

assert_passed $check 0

umount /mnt >> ${log_file} 2>&1
