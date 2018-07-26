#!/bin/bash

#===============================================================================
# DESCRIPTION: Create file1.txt file2.txt file3.txt 
#              Rename .txt file to .t file
#===============================================================================

mkdir test; cd test

mkdir rename.d; cd rename.d

touch file1.txt file2.txt file3.txt > ${log_file} 2>&1

rename.ul .txt .t *.txt >> ${log_file} 2>&1

ls > ${PWD}/../output.txt

cd ..

diff ${PWD}/output.txt ${data_dir}/output_expected.txt > ${PWD}/test.txt

# Check result of testcase
if [ -s ${PWD}/test.txt ]; then
  echo "${test_failed_text}" >> ${RESULT_FILE}
else
  echo "${test_passed_text}" >> ${RESULT_FILE}
fi
cd ..

# Delete non-necessary file
rm -fr test
