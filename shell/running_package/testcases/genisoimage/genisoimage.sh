#!/bin/bash
#
#==============================================================================
# DESCRIPTION: Testing for genisoimage command.
#              1. Uses directory "cddir" for testing genisoimage command to
#              create a vanilla ISO9660 filesystem image.
#              2. Uses directory "cddir" for testing genisoimage command to 
#              create a CD with Rock Ridge extensions.
#              3. Uses directory "cddir" for testing genisoimage command to 
#              create a CD with Rock Ridge extensions and all files have read 
#              permission and be owned by root.
#              4. Uses directory "cddir" for testing genisoimage command to 
#              create a HFS hybrid CD that contains Netatalk Apple/Unix files.
#              5. Uses files "file1, file2, file3" for testing genisoimage to 
#              create an image without root directory.
#              6. Uses directory "cddir" for testing genisoimage command to 
#              create a HFS hybrid CD with the Joliet and Rock Ridge extensions.
#==============================================================================

check=0
echo "Testing genisoimage" > ${log_file}

# Create a vanilla ISO9660 filesystem image.
genisoimage -o cd.iso ${data_dir}/cddir >> ${log_file} 2>&1
ls cd.iso >> ${log_file} 2>&1
if [ $? -ne 0 ]; then
  check=1
fi
rm -f cd.iso

# Create a CD with Rock Ridge extensions.
genisoimage -o cd.iso -R ${data_dir}/cddir >> ${log_file} 2>&1
ls cd.iso >> ${log_file} 2>&1
if [ $? -ne 0 ]; then
  check=1
fi
rm -f cd.iso

# Create a CD with Rock Ridge extensions and all files have read permission 
#and be owned by root.
genisoimage -o cd.iso -r ${data_dir}/cddir >> ${log_file} 2>&1
ls cd.iso >> ${log_file} 2>&1
if [ $? -ne 0 ]; then
  check=1
fi
rm -f cd.iso

# Create a HFS hybrid CD that contains Netatalk Apple/Unix files.
genisoimage -o cd.iso --netatalk ${data_dir}/cddir >> ${log_file} 2>&1
ls cd.iso >> ${log_file} 2>&1
if [ $? -ne 0 ]; then
  check=1
fi
rm -f cd.iso

# Create an image without root directory.
genisoimage -o cd.iso ${data_dir}/file1 ${data_dir}/file2 ${data_dir}/file3 >> ${log_file} 2>&1
ls cd.iso >> ${log_file} 2>&1
if [ $? -ne 0 ]; then
  check=1
fi
rm -f cd.iso

# Create a HFS hybrid CD with the Joliet and Rock Ridge extensions.
genisoimage -o cd.iso -R -J -hfs ${data_dir}/cddir >> ${log_file} 2>&1
ls cd.iso >> ${log_file} 2>&1
if [ $? -ne 0 ]; then
  check=1
fi
rm -f cd.iso

# Check result of testcase
assert_passed $check 0
