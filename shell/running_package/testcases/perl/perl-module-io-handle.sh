#!/bin/bash

#==============================================================================
# DESCRIPTION: Run sample.pl file using perl command
#              type anything while script are running, output is what typed
#==============================================================================

echo "Testing perl-module-io-handle" > ${log_file}

# Run perl script using perl
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | perl ${data_dir}/sample.pl > ${PWD}/io.handle 2>&1
Meta
EOF

cat ${PWD}/io.handle >> ${log_file} 2>&1

diff ${PWD}/io.handle ${data_dir}/output.expected >> ${log_file} 2>&1

# Check result of testcase
assert_passed $? 0

# Remove noneeded file
rm ${PWD}/io.handle
