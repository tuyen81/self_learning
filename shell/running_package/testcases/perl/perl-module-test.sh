#!/bin/bash

#==============================================================================
# DESCRIPTION: Run sample.pl file using perl command
#              Output is test info of test IO Module
#==============================================================================

echo "Testing perl-module-test" > ${log_file}

check=0
# Create file for testing
mkdir -p test 2>> ${log_file}
cd test 2>> ${log_file}
cp ${data_dir}/output.expected . 2>> ${log_file}
cp ${data_dir}/sample.pl . 2>> ${log_file}

# Run perl script using perl
perl sample.pl &> test.txt

if [ $? -ne 0 ]; then
  check=1
fi

cat test.txt >> ${log_file} 2>&1

sed -i '/Current time local/d'  test.txt >> ${log_file} 2>&1
sed -i '/Running under perl version/d'  test.txt >> ${log_file} 2>&1
sed -i '/Current time GMT/d'  test.txt >> ${log_file} 2>&1
sed -i '/Using Test.pm version/d'  test.txt >> ${log_file} 2>&1
sed -i '/Parameterless /d'  test.txt >> ${log_file} 2>&1

diff test.txt ${data_dir}/output.expected >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

cd ../
# Check result of testcase
assert_passed $check 0

# Remove noneeded file
rm -fr test
