#!/bin/bash

#==============================================================================
# DESCRIPTION: ionice command sets  or  gets the I/O scheduling class and priority
#              for a program.
#              This file Runs 'bash' as a best-effort program with highest priority and
#              prints the class and priority of the current processes 'bash'.
#==============================================================================

ionice -p $$ -n 0 -c 0 > ${log_file} 2>&1
ionice -p $$ -n 3 -c 7 >> ${log_file} 2>&1
ionice -p $$ -n 4 -c 7 >> ${log_file} 2>&1
ionice -p $$ -n 1 -c 8 >> ${log_file} 2>&1
ionice -n 3 ls /etc/passwd >> ${log_file} 2>&1
ionice -p $$  >> ${log_file} 2>&1

diff ${log_file} ${data_dir}/output_expected.txt > ${PWD}/test.txt

# Check result of testcase
if [ -s ${PWD}/test.txt ]; then
  echo "${test_failed_text}" >> ${RESULT_FILE}
else
  echo "${test_passed_text}" >> ${RESULT_FILE}
fi
# Delete non-necessary file
rm  ${PWD}/test.txt
