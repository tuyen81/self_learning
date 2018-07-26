#!/bin/bash

#==============================================================================
# DESCRIPTION: Create file and folder then sync file between two folder
#==============================================================================

check=0

echo "Testing rdist" > ${log_file}
# Create some files and directories for testing
mkdir /root/{dist,rdist} >> ${log_file} 2>&1
touch /root/dist/file{1,2,3} >> ${log_file} 2>&1

# Sync files from "dist" to "rdist" using ssh: (localhost : 127.0.0.1)
rdist -P /usr/bin/ssh -c /root/dist/ root@localhost:/root/rdist | sort -u  > ${PWD}/rdist.sync 2>&1

cat ${PWD}/rdist.sync >> ${log_file} 2>&1

diff ${PWD}/rdist.sync ${data_dir}/expected.output >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check if "rdist" directory is synced or not
ls /root/rdist > ${PWD}/synced 2>&1

cat ${PWD}/synced >> ${log_file} 2>&1

diff ${PWD}/synced ${data_dir}/synced.output >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0

# Remove noneeded file
rm -r ${PWD}/synced ${PWD}/rdist.sync /root/dist /root/rdist
