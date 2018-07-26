#!/bin/bash
#==============================================================================
# DESCRIPTION: expr.sh is used to test expr command of coreutils package.
#              Use 'expr' command to prints the value of EXPRESSION to standard output
#              First, Use 'expr' command to find charactor, second Use 'expr' command
#              to compare two integer number. Finally, use 'expr' command to execute
#              an addition
#              Compare output to expected result to show test case pass or fail
#==============================================================================
#run expr commnnd to show Partial match and returns the number of characters matched
expr linux : lin > ${log_file} 2>&1
diff ${log_file} ${data_dir}/expected_result_1.txt > /dev/null 2>&1
if [ $? = "0" ]
then
  # Run expr command to compare an expression
  expr 10 \< 20 > ${log_file} 2>&1
  diff ${log_file} ${data_dir}/expected_result_2.txt > /dev/null 2>&1
  if [ $? = "0" ]
  then
    #Run expr command to perform the integer arithmetic operation
    expr 100 \+ 20 > ${log_file} 2>&1
    diff ${log_file} ${data_dir}/expected_result_3.txt > /dev/null 2>&1
    assert_passed $? 0
  else
    echo ${test_failed_text} >> ${RESULT_FILE}
  fi
else
  echo ${test_failed_text} >> ${RESULT_FILE}
fi
