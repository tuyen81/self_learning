#!/bin/bash
#==============================================================================
# DISCRIPTION: Test script is test to split command.
#              In test script behavior of 'split' command is to generate two
#              files ('xaa' and 'xab' files) from sample.txt file. The sample.txt file
#              has been stored contents 'Line 1\n Line 2\n to Line 10'.
#==============================================================================

# Run "split" command to create 2 files ("xaa" and "xab") from sample.txt file
split -l 5 ${data_dir}/sample.txt > ${log_file} 2>&1

#cat xaa and xab files
cat xaa > ${log_file} 2>&1
cat xab >> ${log_file} 2>&1

# Check result of command split with expected output
diff ${log_file} ${data_dir}/sample.txt

assert_passed $? 0

# Remove xaa and xab files created by "split" command from sample.txt file
rm xaa xab
