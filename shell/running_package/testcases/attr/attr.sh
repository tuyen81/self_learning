#!/bin/bash

#==============================================================================
# DESCRIPTION: Testing for setfattr and getfattr commands.
#              The first, mount a partition with user_xattr option. 
#              After, create a sample.txt file for testing
#              and set extended attributes of file system object by using setfattr 
#              command and then get extended attributes of file system object
#              by using getfattr command.
#==============================================================================

# Prepare a free partition /dev/xxx for testing
. ${CONFIG_DIR}/make_ext3_partition.sh > ${log_file} 2>&1

# Mount /dev/xxx partition with user_xattr option
mount -o user_xattr ${TGTDEV}1 /mnt >> ${log_file} 2>&1

# Create a sample.txt file for testing
touch /mnt/sample.txt
check=0

# Set extended attributes of filesystem object
setfattr -n user.comment -v "This is for testing ${test_case_name}" /mnt/sample.txt >> \
${log_file} 2>&1
if [ $? != "0" ]; then
  check=1
fi

# Get extended attributes of filesystem object
getfattr -d /mnt/sample.txt >> ${log_file} 2>&1

grep user.comment ${log_file} > /dev/null 2>&1
if [ $? != "0" ]; then
  check=1
fi

assert_passed $check 0

umount ${TGTDEV}1 > /dev/null 2>&1

. ${CONFIG_DIR}/format_partition.sh > /dev/null 2>&1
