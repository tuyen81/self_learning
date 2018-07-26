#!/bin/bash

#===============================================================================
# DESCRIPTION: Make partiotion for storage device
#              Create 25M largefile file and Add 15M more to the end of
#              'largefile' with fallocate command 
#===============================================================================

mkdir test; cd test
# Format storage device with ext4
. ${CONFIG_DIR}/create_partition.sh > ${log_file} 2>&1
mkfs.ext4 ${TGTDEV}1 >> ${log_file} 2>&1
sleep 4
# Get partition of storage device
mount -t ext4 ${TGTDEV}1 /mnt >> ${log_file} 2>&1

# Create a 25M file with fallocate:
fallocate -l 25M /mnt/largefile >> ${log_file} 2>&1
ls -lh /mnt/largefile > ${PWD}/output.txt

# Add 15M more to the end of "largefile"
fallocate -o 25M -l 15M /mnt/largefile >> ${log_file} 2>&1
ls -lh /mnt/largefile >> ${PWD}/output.txt

# Using same format with expected output
sed -ie 's/ ... .[0-9] .[0-9]:.[0-9] //g' output.txt
diff ${PWD}/output.txt ${data_dir}/output_expected.txt > ${PWD}/test.txt

# Check result of testcase
if [ -s ${PWD}/test.txt ]; then
  echo "${test_failed_text}" >> ${RESULT_FILE}
else
  echo "${test_passed_text}" >> ${RESULT_FILE}
fi
cd ..

# Delete non-necessary file, format and umount storage device
umount ${TGTDEV}1 >> ${log_file} 2>&1
. ${CONFIG_DIR}/format_partition.sh >> ${log_file} 2>&1
sleep 4
rm -fr test
