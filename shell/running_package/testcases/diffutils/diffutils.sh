#!/bin/bash

#==============================================================================
# DESCRIPTION: Testing for diff, cmp and diff3 commands.
#              The commands are used to compare some files then check actual result 
#              with expected output.
#              Create 3 files and check different of these files.
#==============================================================================

check=0
expected_cmp_output=$(cat ${data_dir}/cmp_expected)
diff ${data_dir}/sample1.txt ${data_dir}/sample2.txt > ${log_file} 2>&1
cmp ${log_file} ${data_dir}/diff_expected >> ${log_file} 2>&1
if [ $? != "0" ]; then
  check=1
fi

cd ${data_dir}
cmp sample1.txt sample2.txt > ${OUTPUT_DIR}/${package_name}/cmp.log 2>&1
cat ${OUTPUT_DIR}/${package_name}/cmp.log >> ${log_file} 2>&1
cd - > /dev/null 2>&1
grep "${expected_cmp_output}" ${OUTPUT_DIR}/${package_name}/cmp.log > /dev/null 2>&1
if [ $? != "0" ]; then
  check=1
fi

diff3 ${data_dir}/sample1.txt ${data_dir}/sample2.txt ${data_dir}/sample3.txt > \
${OUTPUT_DIR}/${package_name}/diff3.log 2>&1
cat ${OUTPUT_DIR}/${package_name}/diff3.log >> ${log_file} 2>&1
cmp ${OUTPUT_DIR}/${package_name}/diff3.log ${data_dir}/diff3_expected
if [ $? != "0" ]; then
  check=1
fi

assert_passed $check 0
