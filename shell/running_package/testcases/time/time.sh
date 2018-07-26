#!/bin/bash

#===============================================================================
# DESCRIPTION: Create sample.sh executable file then using time to run sample.sh
#              time displays information about resources used by sample.sh
#===============================================================================

check=0
echo "Testing time" > ${log_file}

# Create sample.sh file for testing
cat <<EOF> sample.sh
for i in {1..10};do
sleep 1
done
EOF

# Set execute permission for sample.sh
chmod +x sample.sh >> ${log_file} 2>&1

# Displays information about resources used by sample.sh
(time ./sample.sh) >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check resource used by sample.sh
t=`grep "real" ${log_file} | grep 0m | cut -d'm' -f2 | cut -d'.' -f1`

if [ $t -lt 10 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0

# Remove noneeded files
rm sample.sh
