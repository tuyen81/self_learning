#!/bin/bash
#==============================================================================
# DISCRIPTION: Test script is test to 'tac' command.
#              The 'tac' command is uses reverses the contents of sample.txt file.
#              The sample.txt file has been stored contents 'Hello world'.
#==============================================================================

# Use "tac" command to reverses the contents of sample.txt file
tac ${data_dir}/sample.txt > ${log_file} 2>&1

# Check result of command tac with expected output
diff ${data_dir}/expected_out.txt ${log_file} > /dev/null 2>&1

assert_passed $? 0
