#!/bin/bash

#==============================================================================
# DESCRIPTION: Replace, delete and move content of file using ed command
#==============================================================================

check=0

echo "Testing ed" > ${log_file} 2>&1

# Create ed.txt file for testing
cat <<EOF> ed.txt
Hello ed
Line 2
Line 3
Line 4
Line 5
EOF

# Replace "Hello" with "Hi"
echo -e ",s/Hello/Hi/g\nw" | ed -s ${PWD}/ed.txt >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Move line 3,4 to the end of file
echo -e "3,4m$\nw" | ed -s ${PWD}/ed.txt >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Delete line number 2
echo -e "2d\nw" | ed -s ${PWD}/ed.txt >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check content of "ed.txt"
cat ${PWD}/ed.txt >> ${log_file} 2>&1
diff ${data_dir}/ed.expected ${PWD}/ed.txt >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0

# Remove noneeded file
rm ${PWD}/ed.txt
