#!/bin/bash

#===============================================================================
# DESCRIPTION: Create a link then use namei to find the real file
#===============================================================================

> /namei_orig_file
ln -sf /namei_orig_file /namei_link_file

namei /namei_link_file > ${log_file} 2>&1
diff ${log_file} ${data_dir}/output_expected.txt > ${PWD}/test.txt
 
# Check result of testcase
if [ -s ${PWD}/test.txt ]; then
  echo "${test_failed_text}" >> ${RESULT_FILE}
else
  echo "${test_passed_text}" >> ${RESULT_FILE}
fi
cd ..

# Delete test files
rm -f /namei_orig_file /namei_link_file
