#!/bin/bash
#
#==============================================================================
# DESCRIPTION: Testing for geteltorito command.
#              Extract an El Torito image from a bootable CD (grub.iso)
#              and write the data extracted to a file.
#==============================================================================

echo "Testing geteltorito" > ${log_file}

# Extract "grub.iso" CD and write data to "eltorito" file.
geteltorito -o eltorito ${data_dir}/grub.iso >> ${log_file} 2>&1
ls eltorito >> ${log_file} 2>&1

# Check result of testcase
assert_passed $? 0

rm -f eltorito 
