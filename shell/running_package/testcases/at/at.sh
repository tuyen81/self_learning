#!/bin/bash

#===============================================================================
# DESCRIPTION: Create sample.sh executable file then run after 1 minute
#===============================================================================

check=0
echo "Testing at" > ${log_file}

# Create sample.sh file for testing
cat <<EOF> sample.sh
ls / > result.txt
EOF

# Set execute permission for sample.sh
chmod +x sample.sh >> ${log_file} 2>&1

# Set time to run sample.sh
at -f sample.sh now + 1 minute >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

sleep 70

# After 1 minute, check result.txt file
if [ -s ${PWD}/result.txt ]; then
  check=0
else
  check=1
fi

# Check result of testcase
assert_passed $check 0

# Remove noneeded files
rm sample.sh result.txt
