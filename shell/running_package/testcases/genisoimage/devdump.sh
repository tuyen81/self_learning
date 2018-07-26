#!/bin/bash
#
#==============================================================================
# DESCRIPTION: Testing for devdump command.
#              Display the contents of "cd.iso" image. The initial screen is a 
#              display of the first 256 bytes of the first 2048 byte sector
#==============================================================================

echo "Testing devdump" > ${log_file}

# Display the contents of "cd.iso" image.
script -q -c "devdump -i ${TESTCASES_DIR}/${package_name}/data/cd.iso" >> ${log_file} 2>&1 << EOF
q
EOF
cat ${log_file} | grep "Zone, zone offset:" >> ${log_file} 2>&1

# Check result of testcase
assert_passed $? 0

rm -f typescript
