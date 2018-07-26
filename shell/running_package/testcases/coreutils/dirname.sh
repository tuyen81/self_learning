#!/bin/bash
#==============================================================================
# DESCRIPTION: dirname.sh is used to test 'dirname' command of coreutils package.
#              Use dirname to show NAME with its last non-slash component
#	       and trailing slashes removed
#              Compare output to expected result to show test case pass or fail
#==============================================================================
#Create expected output
echo "/usr/bin" > expected_output_1.txt
echo "." > expected_output_2.txt
#run command dirname to show Name with its last non-slash
dirname /usr/bin/sort > ${log_file} 2>&1
diff ${log_file} expected_output_1.txt 2>&1
if [ $? = "0" ]
then
  dirname stdio.h > ${log_file} 2>&1
  diff ${log_file} expected_output_2.txt 2>&1
  assert_passed $? 0
else
  echo ${test_failed_text} >> ${RESULT_FILE}
fi
rm -f expected_output_1.txt expected_output_2.txt
