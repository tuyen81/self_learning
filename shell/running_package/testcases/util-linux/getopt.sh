#!/bin/bash

#===============================================================================
# DESCRIPTION: Break up (parse) options in command lines function of getopt command
#===============================================================================

mkdir test; cd test

getopt ls -l /etc > ${log_file} 2>&1

diff ${log_file} ${data_dir}/output_expected.txt > ${PWD}/test.txt

# Check result of testcase
if [ -s ${PWD}/test.txt ]; then
  echo "${test_failed_text}" >> ${RESULT_FILE}
else
  echo "${test_passed_text}" >> ${RESULT_FILE}
fi
cd ..

# Delete non-necessary file
rm -fr test
