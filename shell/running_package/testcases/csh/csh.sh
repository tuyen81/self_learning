#!/bin/bash

#===============================================================================
# DESCRIPTION: Create test.csh executable file then run with csh
#===============================================================================

check=0
echo "Testing csh" > ${log_file}

# Create sample.csh file for testing
cat <<EOF> ${PWD}/sample.csh
#!/bin/csh
set a = 2
if ( \$a > 1 ) then
   echo Testing for csh
endif
EOF

# Set execute permission for sample.csh
chmod +x sample.csh >> ${log_file} 2>&1

# Run sample.csh with csh
csh sample.csh > ${log_file} 2>&1

grep "Testing for csh" ${log_file} > /dev/null

if [ $? -ne 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0

# Remove unneeded file
rm ${PWD}/sample.csh
