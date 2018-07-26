#!/bin/bash

#==============================================================================
# DESCRIPTION: Testing for base64 command.
#              The first, base64 encodes a file and then it decodes a file with -d option 
#==============================================================================

base64 ${data_dir}/sample.txt |tee sample_base64.txt > ${OUTPUT_DIR}/${package_name}/tmp.log 2>&1
cp ${OUTPUT_DIR}/${package_name}/tmp.log ${log_file} 2>/dev/null
check=0
diff ${OUTPUT_DIR}/${package_name}/tmp.log ${data_dir}/expected1_output >> ${log_file} 2>&1
if [ $? != "0" ]; then
  check=1
fi

base64 -d sample_base64.txt > ${OUTPUT_DIR}/${package_name}/tmp.log 2>&1
cat ${OUTPUT_DIR}/${package_name}/tmp.log >> ${log_file}
diff ${OUTPUT_DIR}/${package_name}/tmp.log ${data_dir}/expected2_output >> ${log_file} 2>&1
if [ $? != "0" ]; then
  check=1
fi

assert_passed $check 0

rm -rf ${OUTPUT_DIR}/${package_name}/tmp.log
rm -rf sample_base64.txt
