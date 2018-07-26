#!/bin/bash

#==============================================================================
# DESCRIPTION: Run sample.pl file using perl command
#              Output display sha code of file
#==============================================================================

echo "Testing perl-module-digest-sha" > ${log_file}

# Run perl script using perl
perl ${data_dir}/sample.pl | grep "b94d27b9934d3e08a52e52d7da7dabfac484efe37a5380ee9088f7ace2efcde9" >> ${log_file} 2>&1

# Check result of testcase
assert_passed $? 0
