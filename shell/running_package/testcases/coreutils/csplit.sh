#!/bin/bash
#==============================================================================
# DISCRIPTION: Test script is test to 'csplit' command.
#              In test script behavior of 'csplit' command is splits a sample.txt file
#              into sections, based on context lines.
#              The sample.txt file has been stored contents 'Line 1\n Line 2\n to Line 9\n Line 10'.
#==============================================================================
# Run "csplit" command to create 2 files ("xx00" and "xx01") from sample.txt file
csplit ${data_dir}/sample.txt 5 > ${log_file} 2>&1
#cat xx00 and xx01 files
cat xx00 > ${log_file} 2>&1
cat xx01 >> ${log_file} 2>&1
# Check result of command csplit with expected output
diff ${log_file} ${data_dir}/sample.txt

assert_passed $? 0

# Remove xx00 and xx01 files created by "csplit" command from sample.txt file
rm xx00 xx01
