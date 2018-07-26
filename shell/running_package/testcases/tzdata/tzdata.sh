#!/bin/bash

#===============================================================================
# DESCRIPTION: Change timezone by create soft link local time and zoneinfo
#              Run date command to check timezone was changed or not
#              After checked, revert localtime to default
#===============================================================================

TIME=`cat /etc/timezone`

mkdir test; cd test

# Command 'date' will get timezone base on TZ if it is set
TZ_BACKUP=$TZ
unset TZ

# Change time to GMT timezone
ln -sf /usr/share/zoneinfo/GMT /etc/localtime > ${log_file} 2>&1
date > ${PWD}/output.txt

# Change time to UTC timezone
ln -sf /usr/share/zoneinfo/UTC /etc/localtime >> ${log_file} 2>&1
date >> ${PWD}/output.txt
sed -ie 's/^.*:.. //g' ${PWD}/output.txt
sed -ie 's/ .*$//g' ${PWD}/output.txt

diff ${PWD}/output.txt ${data_dir}/output_expected.txt > ${PWD}/test.txt
if [ -s ${PWD}/test.txt ]; then
  echo "${test_failed_text}" >> ${RESULT_FILE}
else
  echo "${test_passed_text}" >> ${RESULT_FILE}
fi
cd ..

# Delete non-necessary files and reset date time and timezone
rm -fr ${PWD}/test
ln -sf /usr/share/zoneinfo/${TIME} /etc/localtime >> ${log_file} 2>&1
export TZ=${TZ_BACKUP}
