#!/bin/bash
#
#==============================================================================
# DESCRIPTION: Testing for mkzftree command.
#              Create a zisofs/RockRidge compressed file tree for "sampledir" 
#              directory.
#==============================================================================

echo "Testing mkzftree" > ${log_file}

# Create a zisofs/RockRidge compressed file tree for "sampledir" directory.
mkzftree -p 9 --one-filesystem ${data_dir}/sampledir/ compressedft >> ${log_file} 2>&1
ls compressedft >> ${log_file} 2>&1

# Check result of testcase
assert_passed $? 0

rm -rf compressedft 
