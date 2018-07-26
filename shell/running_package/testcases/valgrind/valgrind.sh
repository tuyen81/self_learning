#!/bin/bash

#===============================================================================
# DESCRIPTION: Create executable file then debug them by using valgrind command 
#===============================================================================

check=0
echo "Testing valgrind" > ${log_file}

# Create file and directory for testing
cp -r ${data_dir}/* /bin/ >> ${log_file} 2>&1

# Debug executable file using valgrind
valgrind /bin/corr_valg > ${PWD}/corr_log 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

grep "ERROR SUMMARY: 0 errors from 0 contexts" ${PWD}/corr_log >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

cat ${PWD}/corr_log >> ${log_file}

# Check result of testcase
assert_passed $check 0

# Remove noneeded files
rm -rf /bin/corr_valg ${PWD}/corr_log
