#!/bin/bash

#===============================================================================
# DESCRIPTION: Find where ls command was located using whereis command
#===============================================================================

mkdir test; cd test
whereis ls > ${log_file} 2>&1
grep 'ls: \/bin\/ls \|ls: \/bin\/ls.coreutils\|ls: \/bin\/ls \/bin\/ls.coreutils' ${log_file} > ${PWD}/test.txt

# Check result of testcase
if [ -s ${PWD}/test.txt ]; then
  echo "${test_passed_text}" >> ${RESULT_FILE}
else
  echo "${test_failed_text}" >> ${RESULT_FILE}
fi
cd ..

# Delete non-necessary file
rm -fr test
