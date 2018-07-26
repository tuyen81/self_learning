#!/bin/bash

#==============================================================================
# DESCRIPTION: Run a perl script file using perl command
#              Output display list of core mudules need for script
#==============================================================================

echo "Testing perl-module-corelist" > ${log_file}

check=0
# Run perl script using perl
perl ${data_dir}/sample.pl | grep "Test::Harness::Assert, Test::Harness::Results, Test::Harness::Straps" >> ${log_file} 2>&1

# Check result of testcase
assert_passed $? 0
