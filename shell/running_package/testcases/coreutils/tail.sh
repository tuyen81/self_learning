#!/bin/bash
#==============================================================================
# DISCRIPTION: Test script is test to 'tail' command.
#              In test script use 'tail' command to display four line the tail
#              end of a sample.txt file.
#              The sample.txt file has been stored contents '1\n 2\n to 9\n 10'.
#==============================================================================

# Use "tail" command to display four line the tail end of a sample.txt file
tail -n4 ${data_dir}/sample.txt > ${log_file} 2>&1

# Check result of command tail with expected output
diff ${data_dir}/expected_out.txt ${log_file} > /dev/null 2>&1

assert_passed $? 0
