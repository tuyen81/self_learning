#!/bin/bash
#==============================================================================
# DISCRIPTION: Run a shred script with the shred command.
#              The shred script securely delete a sample.txt file. The sample.txt file
#              has been stored contents Hello world.
#==============================================================================

check=0

# Create a directory and a sample.txt file for testing
mkdir -p ${data_dir}
touch ${data_dir}/sample.txt

# Stored contents "Hello world" to sample.txt file
echo "Hello world" > ${data_dir}/sample.txt
echo "Hello world" > ${PWD}/shred.txt
# Wipe data
shred -vfz -n 3 ${data_dir}/sample.txt > ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check contend after wipe
diff ${data_dir}/sample.txt ${PWD}/shred.txt >> ${log_file} 2>&1

if [ $? -eq 0 ]; then
  check=1
fi

# Check result of command shred with expected output
assert_passed $check 0

rm -rf ${data_dir} ${PWD}/shred.txt
