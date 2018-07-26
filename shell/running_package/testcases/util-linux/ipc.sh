#!/bin/sh

#===============================================================================
# DESCRIPTION: Create shared memory segments, message queues, and 
#              semaphore arrays; shows information on the inter-process 
#              communication facilities
#===============================================================================

check=0

ipcmk -M 512 -Q -S 5 > ${log_file} 2>&1

# get message queue id
Mess_id=`grep "Message queue id" ${log_file} | sed 's/^.*\s//g'`

ipcs -a >> ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

ipcrm -q $Mess_id >> ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

ipcs -q -i $Mess_id >> ${log_file} 2>&1

grep "ipcs: id $Mess_id not found" ${log_file} &> /dev/null

if [ $? != "0" ]; then
  check=1
fi

# Check test result
assert_passed $check 0
