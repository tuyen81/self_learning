#!/bin/bash

#==============================================================================
# DESCRIPTION: List status of service, enable service on some levels then
#              Disable service on some runlevels
#==============================================================================

check=0

echo "Testing chkconfig" > ${log_file}
# Get status of service
chk=`chkconfig -l networking | sed -e 's/^.*0/0/' | sed 's/[0-9]:off//g' | sed 's/[ :on]//g'`

# Listing the status of services
chkconfig -l networking | grep "networking" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Enabling a Service in runlevels 2, 3, 4, 5
chkconfig -s networking 2345 >> ${log_file} 2>&1
chkconfig -l networking | sed -e 's/^.*0/0/' | sed 's/[0-9]:off//g' | sed 's/[ :on]//g' | grep "2345" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Disabling a Service
chkconfig networking off  >> ${log_file} 2>&1
chkconfig -l networking | grep "on" >> ${log_file} 2>&1

if [ $? -eq 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0

# Restore default config
chkconfig -s networking $chk >> ${log_file} 2>&1
