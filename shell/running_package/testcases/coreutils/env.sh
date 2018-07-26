#!/bin/bash
#==============================================================================
# DESCRIPTION: env.sh is used to test 'env' command of coreutils package.
#              Use env command to show system Enviroment variable and set a
#              specific enviroment variable
#              Compare output to expected result to show test case pass or fail
#==============================================================================
#run env command to list system enviroment varibale
env > ${log_file} 2>&1
grep -nr "USER=root" ${log_file} > /dev/null 2>&1
if [ $? = "0" ]
then
  # Run env command to set a specific enviroment variable
  env TMP_VAR="env testing" | grep TMP_VAR  > ${log_file} 2>&1
  diff ${log_file} ${data_dir}/expected_result.txt > /dev/null 2>&1
  if [ $? = "0" ]
  then
    #Run env command with option -u to unset varibale and check result
    env env -u TMP_VAR | grep TMP_VAR
    assert_passed $? 1
  else
    echo ${test_failed_text} >> ${RESULT_FILE}
  fi
else
echo ${test_failed_text} >> ${RESULT_FILE}
fi
