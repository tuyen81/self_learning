#!/bin/bash
#==============================================================================
# DISCRIPTION: Testing for network time protocol(ntp) service.
#              Testing and checking runtime status information about 'restart',
#              'stop' and 'start' network time protocol.
#==============================================================================

check=0

# Declare variable expected output
ACTIVE_RUNNING="active (running)"
INACTIVE_DEAD="inactive (dead)"

# Run command restart service
systemctl restart ntp > ${log_file} 2>&1

if [ $? != "0" ]; then
  /etc/init.d/ntp restart >> ${log_file} 2>&1
fi

# Gets status ntp after restart service
systemctl status -l ntp >> ${log_file} 2>&1

if [ $? = "0" ]; then
  systemctl status -l ntp | grep "${ACTIVE_RUNNING}" >> ${log_file} 2>&1
  if [ $? != "0" ]; then
    check=1
  fi
else
  /etc/init.d/ntp status | grep "${ACTIVE_RUNNING}" >> ${log_file} 2>&1
  if [ $? != "0" ]; then
    check=1
  fi
fi

# Run command stop service
systemctl stop ntp >> ${log_file} 2>&1

if [ $? != "0" ]; then
  /etc/init.d/ntp stop >> ${log_file} 2>&1
fi

# Gets status ntp after stop service
systemctl status -l ntp >> ${log_file} 2>&1

if [ $? = "0" ]; then
  systemctl status -l ntp | grep "${INACTIVE_DEAD}" >> ${log_file} 2>&1
  if [ $? != "0" ]; then
    check=1
  fi
else
  /etc/init.d/ntp status | grep "${INACTIVE_DEAD}" >> ${log_file} 2>&1
  if [ $? != "0" ]; then
    check=1
  fi
fi

# Run command start service
systemctl start ntp >> ${log_file} 2>&1

if [ $? != "0" ]; then
  /etc/init.d/ntp start >> ${log_file} 2>&1
fi
# Gets status ntp after start service
systemctl status -l ntp >> ${log_file} 2>&1

if [ $? = "0" ]; then
  systemctl status -l ntp | grep "${ACTIVE_RUNNING}" >> ${log_file} 2>&1
  if [ $? != "0" ]; then
    check=1
  fi
else
  /etc/init.d/ntp status | grep "${ACTIVE_RUNNING}" >> ${log_file} 2>&1
  if [ $? != "0" ]; then
    check=1
  fi
fi

#Check result of command ntp with expected output
assert_passed $check 0
