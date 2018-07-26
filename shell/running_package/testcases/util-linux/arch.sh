#!/bin/bash

#===============================================================================
# DESCRIPTION: Get arch name using uname and compare with arch command
#===============================================================================

mkdir test; cd test

uname -m > ${log_file} 2>&1

arch > ${PWD}/output.txt

diff ${PWD}/output.txt ${log_file} > ${PWD}/test.txt

arch >> ${log_file} 2>&1

# Check result of testcase
if [ -s ${PWD}/test.txt ]; then
  echo "${test_failed_text}" >> ${RESULT_FILE}
else
  echo "${test_passed_text}" >> ${RESULT_FILE}
fi
cd ..

# Delete non-necessary file
rm -fr test
