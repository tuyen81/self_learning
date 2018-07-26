#!/bin/bash

#==============================================================================
# DESCRIPTION: Create test.py file then run with python, output print Hello World
#==============================================================================

# Create test.py for testing
cat <<EOF> test.py
print "Hello World"
EOF

# Run test.py file
python test.py | grep "Hello World" > ${log_file} 2>&1

# Check result of testcase
assert_passed $? 0

# Remove noneeded file
rm test.py
