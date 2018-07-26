#!/bin/bash
# author: datnd
#=========================================================================
# DESCRIPTION: Testing for checking user´s login name by logname command,
#              checking effective userid by logname command,
#              checking the user names of users currently logged 
#              in to the current host by users command.
#=========================================================================

RESULT=1

# run step 1
OUTPUT_STEP_1=`logname` 2> ${log_file}
echo -e "OUTPUT_STEP_1:\n""${OUTPUT_STEP_1}" >> ${log_file}
if [ "`cat /etc/passwd | grep "\/${OUTPUT_STEP_1}:"`" ]
then
  echo "STEP 1 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 1 FAILED" >> ${log_file}
fi
# run step 2
OUTPUT_STEP_2=`users /var/log/wtmp` 2>> ${log_file}
echo -e "OUTPUT_STEP_2:\n""${OUTPUT_STEP_2}" >> ${log_file}
if [ "`echo "${OUTPUT_STEP_2}" | grep "root"`" ]
then
  echo "STEP 2 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 2 FAILED" >> ${log_file}
fi
# run step 3
OUTPUT_STEP_3=`whoami` 2>> ${log_file}
echo -e "OUTPUT_STEP_3:\n""${OUTPUT_STEP_3}" >> ${log_file}
if [ "${OUTPUT_STEP_3}"  = "root" ]
then
  echo "STEP 3 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 3 FAILED" >> ${log_file}
fi

# check result after running all steps
assert_passed ${RESULT} 1
