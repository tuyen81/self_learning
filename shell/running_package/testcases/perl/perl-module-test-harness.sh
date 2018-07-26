#!/bin/bash

#==============================================================================
# DESCRIPTION: Run sample.pl file using perl command
#              Output is test info of test IO
#==============================================================================

echo "Testing perl-module-test-harness" > ${log_file}

check=0
# Create file for testing
mkdir -p ${PWD}/harness 2>> ${log_file}
cd ${PWD}/harness  2>> ${log_file}
cp ${data_dir}/simple .  2>> ${log_file}
cp ${data_dir}/Harness.pl .  2>> ${log_file}

# Run perl script using perl
perl Harness.pl &> harness.txt 2>&1

if [ $? -eq 0 ]; then
  check=1
fi

cat harness.txt >> ${log_file} 2>&1

sed -i '/wallclock secs /d'  harness.txt >> ${log_file} 2>&1

diff harness.txt ${data_dir}/output.expected >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

cd ..
# Check result of testcase
assert_passed $check 0

# Remove noneeded file
rm -rf harness
