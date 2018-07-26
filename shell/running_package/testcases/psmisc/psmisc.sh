#!/bin/bash
#==============================================================================
# DISCRIPTION: Using the 'killall' command of 'psmisc' package to kills a process
#              by it's name with '-SIGHUP' option and no option
#==============================================================================

PROCESS1_NAME="cron"
PROCESS2_NAME="rpcbind"
check=0

# Start "cron" and "rpcbind" service
systemctl start cron
systemctl start rpcbind

# Display a tree of process
pstree > ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

# Kill process with option "-SIGHUP"
killall -SIGHUP "${PROCESS1_NAME}" >> ${log_file} 2>&1
pstree | grep "${PROCESS1_NAME}" >> ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

# Kill process "rpcbind" with no option
killall "${PROCESS2_NAME}" >> ${log_file} 2>&1
pstree | grep "${PROCESS2_NAME}" >> ${log_file} 2>&1

if [ $? = "0" ]; then
  check=1
fi

#Check result of command psmisc with expected output
assert_passed $check 0
