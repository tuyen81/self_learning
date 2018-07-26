#!/bin/bash
# author: datnd
#========================================================================================
# DESCRIPTION: Testing for runinng a program sh file with modified scheduling priority 7
#========================================================================================

RESULT=1
EXP_OUTPUT_STEP_4=7
EXP_OUTPUT_STEP_2=0

# run step 1
sh ${data_dir}/sample.sh & > ${log_file}
if [ $? = 0 ]
then
  echo "STEP 1 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 1 FAILED" >> ${log_file}
fi
# Process need time to start
sleep 1

# run step 2
ps a -o ni,cmd= | grep "${EXP_OUTPUT_STEP_2} [s]h ${data_dir}/sample.sh" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  RESULT=0
fi
# Kill process
kill -9 `pgrep -f "sh ${data_dir}/sample.sh"` >> ${log_file}

# run step 3
nice -${EXP_OUTPUT_STEP_4} sh ${data_dir}/sample.sh & >> ${log_file}
if [ $? = 0 ]
then
  echo "STEP 3 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 3 FAILED" >> ${log_file}
fi
# Process need time to start
sleep 1

# run step 4
ps a -o ni,cmd= | grep "${EXP_OUTPUT_STEP_4} [s]h ${data_dir}/sample.sh" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  RESULT=0
fi
# Kill process
kill -9 `pgrep -f "sh ${data_dir}/sample.sh"` >> ${log_file} 2>&1

# check result of testting
assert_passed $RESULT 1
