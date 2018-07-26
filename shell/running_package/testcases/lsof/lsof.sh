#!/bin/bash
#==============================================================================
# DESCRIPTION: lsof.sh tests lsof command of lsof package.
#              First, run lsof command to find out which files are open by 
#              which process, then run lsof command with optionn -i (select IPv[46] files). 
#==============================================================================
. ${CONFIG_DIR}/network.sh
#List all open files with lsof
lsof > ${log_file} 2>&1
#check output of list command
grep "\/bin\/bash\|\/bin\/sh" ${log_file} > /dev/null 2>&1
if [ $? = "0" ]
then
  #List all the TCP or UDP connections by specifying the protocol using ‘-i’
  lsof -i TCP > ${log_file} 2>&1 
  grep "IPv4" ${log_file} >> /dev/null 2>&1
  assert_passed $? 0 
else
  echo ${test_failed_text} >> ${RESULT_FILE}
fi
