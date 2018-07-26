#!/bin/bash

#===============================================================================
# DESCRIPTION: Using vim command to write some text and save to test_vim file
#===============================================================================

check=0
echo "Testing for vim" > ${log_file} 2>&1

# Check .vimrc existed or not
ls ~/.vimrc >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
  touch ~/.vimrc >> ${log_file} 2>&1
fi

. ${data_dir}/content.sh >> ${log_file} 2>&1

diff ${PWD}/test_vim ${data_dir}/output_expected.txt > ${PWD}/test.txt

# Check result of testcase
if [ -s ${PWD}/test.txt ]; then
  echo "${test_failed_text}" >> ${RESULT_FILE}
else
  echo "${test_passed_text}" >> ${RESULT_FILE}
fi

# Remove non-necessary file
rm -fr ${PWD}/test.txt ${PWD}/test_vim

if [ $check -eq 1 ]; then
  rm -rf ~/.vimrc
fi
