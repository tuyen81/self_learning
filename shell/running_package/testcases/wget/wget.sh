#!/bin/bash

#===============================================================================
# DESCRIPTION: Run wget command to download index.html file 
#              from google.com webpage
#===============================================================================

mkdir test; cd test
wget https://google.com > ${log_file} 2>&1
ls >> ${log_file} 2>&1
ls > ${PWD}/test.txt

if [ -s ${PWD}/test.txt ]; then
  echo "${test_passed_text}" >> ${RESULT_FILE}
else
  echo "${test_failed_text}" >> ${RESULT_FILE}
fi

cd ..
# Delete non-necessary folder after testing
rm -fr test
