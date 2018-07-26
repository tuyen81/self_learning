#!/bin/bash
#==============================================================================
# DESCRIPTION: id.sh is use to test 'id' command of coreutils package.
#              Use 'id' command to find an USER ID(UID) or GROUP ID(GID)
#              Compare output to expected result to show test case pass or fail
#              This testcase must run in root to use useradd command
#==============================================================================
#Use useradd command to create user tec
useradd -U tec

#Create expected output file
echo "uid=0(root) gid=0(root) groups=0(root)" > expected_result.txt

#run id commnnd to find USER ID(UID) or GROUP ID(GID) of user root
id root > ${log_file} 2>&1

diff ${log_file} expected_result.txt > /dev/null 2>&1

if [ $? = "0" ]
then
  #run id commnnd to find USER ID(UID) or GROUP ID(GID) of user tec
  id tec > ${log_file} 2>&1
  grep -nr "tec" ${log_file} > /dev/null 2>&1
  assert_passed $? 0
else
  echo ${test_failed_text} >> ${RESULT_FILE}
fi

rm -f expected_result.txt

userdel tec
