#!/bin/sh
# author: datnd
#==============================================================================
# DESCRIPTION: Testing for listing attributes of sample file by lsattr command
#              Changing attributes of sample file by chattr command
#              Displaying superblock information about sda1 by dumpe2fs command
#==============================================================================

echo "Testing e2fsprogs" > ${log_file}

. ${CONFIG_DIR}/make_ext3_partition.sh >> ${log_file} 2>&1

#Mount partition with format ext3
mount ${TGTDEV}1 /mnt

RESULT=1
EXP_OUTPUT_STEP_1="e--"
EXP_OUTPUT_STEP_3="suS-iadAcj"
EXP_OUTPUT_STEP_4="Filesystem volume name"

#prepare for testing
mkdir -p ${OUTPUT_DIR}/${package_name}/tmp
touch ${OUTPUT_DIR}/${package_name}/tmp/sample.txt

# run step 1
OUTPUT_STEP_1=`lsattr ${OUTPUT_DIR}/${package_name}/tmp/sample.txt` >> ${log_file} 2>&1
echo "OUTPUT_STEP_1:\n""${OUTPUT_STEP_1}" >> ${log_file}
if [ -n "`echo "${OUTPUT_STEP_1}" | grep "${EXP_OUTPUT_STEP_1}"`" ]
then
  echo "STEP 1 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 1 FAILED" >> ${log_file}
fi

#run step 2
chattr +AacdijsSu ${OUTPUT_DIR}/${package_name}/tmp/sample.txt >> ${log_file} 2>&1

# run step 3
OUTPUT_STEP_3=`lsattr ${OUTPUT_DIR}/${package_name}/tmp/sample.txt` 2>> ${log_file}
echo "OUTPUT_STEP_3:\n""${OUTPUT_STEP_3}" >> ${log_file}
if [ -n "`echo "${OUTPUT_STEP_3}" | grep "${EXP_OUTPUT_STEP_3}"`" ]
then
  echo "STEP 3 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 3 FAILED" >> ${log_file}
fi

# run step 4
dumpe2fs -h ${TGTDEV}1 > temp_output_file 2>&1
echo "OUTPUT_STEP_4:" >> ${log_file}
cat temp_output_file >> ${log_file}
if [ -n "`cat temp_output_file | grep "${EXP_OUTPUT_STEP_4}"`" ]
then
  echo "STEP 4 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 4 FAILED" >> ${log_file}
fi

# check result after running all steps
assert_passed ${RESULT} 1

# clean uneeded output
chattr -AacdijsSu ${OUTPUT_DIR}/${package_name}/tmp/sample.txt
rm -rf ${OUTPUT_DIR}/${package_name}/tmp
rm temp_output_file

umount ${TGTDEV}1
. ${CONFIG_DIR}/format_partition.sh >> ${log_file} 2>&1
