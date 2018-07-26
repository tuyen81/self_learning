#!/bin/bash

#==============================================================================
# DESCRIPTION: This testcase Generating a Unix-style Makefile from .pm file
#==============================================================================

check=0
echo "Testing perl-module-extutils-makemaker" > ${log_file}

# Create file and directory for testing
cp -r ${data_dir} ${PWD}/testing_perl_module >> ${log_file} 2>&1

cd ${PWD}/testing_perl_module

# Generating a Unix-style Makefile
perl Makefile.pl >> ${log_file} 2>&1

ls | grep -v "Makefile.pl" | grep "Makefile" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

if [ -s ${PWD}/Makefile ]; then
  check=0
else
  check=1
fi

cd ..

# Check result of testcase
assert_passed $check 0

# Remove unneeded file
rm -rf ${PWD}/testing_perl_module
