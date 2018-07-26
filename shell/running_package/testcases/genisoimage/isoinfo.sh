#!/bin/bash
#
#==============================================================================
# DESCRIPTION: Testing for isoinfo command.
#              Read an ISO-9660 image (cd.iso) from SCSI
#              target and print information from the primary volume descriptor.
#==============================================================================

echo "Testing isoinfo" > ${log_file}

# Read "cd.iso" image.
isoinfo -d -i ${TESTCASES_DIR}/${package_name}/data/cd.iso >> ${log_file} 2>&1

# Check result of testcase
assert_passed $? 0

