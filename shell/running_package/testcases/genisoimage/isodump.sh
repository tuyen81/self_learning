#!/bin/bash
#
#==============================================================================
# DESCRIPTION: Testing for isodump command.
#              Display the contents of "cd.iso" image in order to verify 
#              directory integrity. The initial screen is a display of the 
#              first part of the root directory, and the prompt shows you the 
#              extent number and offset in the extent.
#==============================================================================

echo "Testing isodump" > ${log_file}

# Display the contents of "cd.iso" image in order to verify directory integrity.
script -q -c "isodump -i ${TESTCASES_DIR}/${package_name}/data/cd.iso" >> ${log_file} 2>&1 << EOF
q
EOF
cat ${log_file} | grep "Zone, zone offset:" >> ${log_file} 2>&1

# Check result of testcase
assert_passed $? 0

rm -f typescript
