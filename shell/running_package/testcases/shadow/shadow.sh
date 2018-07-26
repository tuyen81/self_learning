#!/bin/bash

#===============================================================================
# DESCRIPTION: Create new user and group then delete them using useradd, userdel
#              Groupadd and groupdel
#===============================================================================

check=0

echo "Testing shadow" > ${log_file}
# Create new group and new user
groupadd testgroupadd >> ${log_file} 2>&1
grep "testgroupadd" /etc/group >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

useradd testuseradd -G testgroupadd >> ${log_file} 2>&1
grep "testuseradd" /etc/passwd >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi


# Set password for testuseradd
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | passwd testuseradd >> ${log_file} 2>&1
1
1
EOF

if [ $? -ne 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0

# Delete user and group
userdel testuseradd >> ${log_file} 2>&1
groupdel testgroupadd >> ${log_file} 2>&1
