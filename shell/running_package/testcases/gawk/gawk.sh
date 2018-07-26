#!/bin/sh
# author: datnd
#=========================================================================
# DESCRIPTION: Testing for scanning follow pattern by gawk command
#=========================================================================

RESULT=1
EXP_OUTPUT_STEP_1="2\n5\n8"
EXP_OUTPUT_STEP_2="FileSystem"

#prepare for testing
mkdir -p ${OUTPUT_DIR}/${package_name}/tmp

# run step 1
echo -e "${EXP_OUTPUT_STEP_1}" > ${OUTPUT_DIR}/${package_name}/tmp/base_file.txt

OUTPUT_STEP_1=`gawk '{print $2}' ${data_dir}/sample.txt` 2> ${log_file}

echo -e "OUTPUT_STEP_1:\n""${OUTPUT_STEP_1}" >> ${log_file}

if [ "${OUTPUT_STEP_1}" = "`cat ${OUTPUT_DIR}/${package_name}/tmp/base_file.txt`" ]
then
  echo "STEP 1 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 1 FAILED" >> ${log_file}
fi

# run step 2
OUTPUT_STEP_2=`df -h \
              | grep "cgroup" \
              | gawk '{print "FileSystem:"$1"\t""Size:"$2"\t""UsedSpace:"$3"\t"\
              "AvailableSpace:"$4"\t""UsedPercentage:"$5"\t""MountPoint:"$6}'` \
              2>>  ${log_file}

echo "OUTPUT_STEP_2:\n""${OUTPUT_STEP_2}" >> ${log_file}

if [ -n "`echo "${OUTPUT_STEP_2}" | grep "${EXP_OUTPUT_STEP_2}"`" ]
then
  echo "STEP 2 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 2 FAILED" >> ${log_file}
fi

# check result after running all steps
assert_passed ${RESULT} 1

# clean unneeded output
rm -rf ${OUTPUT_DIR}/${package_name}/tmp 
