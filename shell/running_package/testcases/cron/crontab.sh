#!/bin/bash

#==============================================================================
# DESCRIPTION: Testing for crontab command.
#              The crontab command is used to execute ls scheduled command.
#==============================================================================

ls / > ${data_dir}/expected_output 2>&1

check=0

# Make this folder because crontab_job file cannot read variable environment
mkdir -p /tmp/test-${test_case_name}
crontab ${data_dir}/crontab_job

if [ $? != "0" ]; then
  check=1
fi

/etc/init.d/cron start > /dev/null 2>&1

if [ $? != "0" ]; then
  check=1
fi

sleep 1m

/etc/init.d/cron stop > /dev/null 2>&1

if [ $? != "0" ]; then
  check=1
fi

mv /tmp/test-${test_case_name}/crontab_output ${log_file}
diff ${data_dir}/expected_output ${log_file} >> ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

assert_passed $? 0

rm -rf ${data_dir}/expected_output
rm -rf /tmp/test-${test_case_name}
