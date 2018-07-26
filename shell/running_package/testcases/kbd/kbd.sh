#!/bin/bash
#==============================================================================
# DESCRIPTION: kbd.sh tests kbd_mode and kbdrate commands of
#              kbd package 
#              Run kbd_mode without argument to print the current keyboard mode
#              to stdout
#              Run kbdrate without any options to reset the repeat rate and 
#              the delay time.
#==============================================================================
check=0

# Get keyboard mode:
kbd_mode > ${log_file} 2>&1
if [ $? != "0" ]; then
  check=1
fi

# Get keyboard repeat rate and delay time:
kbdrate >> ${log_file} 2>&1
if [ $? != "0" ]; then
  check=1
fi

grep delay ${log_file} > /dev/null 2>&1
if [ $? != "0" ]; then
  check=1
fi

assert_passed $check 0
