#!/bin/bash

#==============================================================================
# DESCRIPTION: Testing for dbus service.
#              The systemctl command is used to start and check status of dbus service.
#==============================================================================
check=0
systemctl start dbus > ${log_file} 2>&1

if [ $? != "0" ]; then
  /etc/init.d/dbus start >> ${log_file} 2>&1
fi

systemctl status -l dbus >> ${log_file} 2>&1

if [ $? = "0" ]; then
  systemctl status -l dbus | grep " active (running)" >> ${log_file} 2>&1
  if [ $? != "0" ]; then
    check=1
  fi
else
  /etc/init.d/dbus status | grep " active (running)" >> ${log_file} 2>&1
  if [ $? != "0" ]; then
    check=1
  fi
fi

assert_passed $check 0
