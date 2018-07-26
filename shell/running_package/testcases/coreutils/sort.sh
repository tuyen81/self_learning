#!/bin/bash
#==============================================================================
# DISCRIPTION: Test script is test to 'sort' command.
#              The sort is a standard command line program that prints the
#              lines of it's input or concatenation of all files listed in it's
#              argument list in sorted order
#==============================================================================

# Run "sort" command with parameter corresponding
echo -e "5\n2\n3\n4\n1" | sort -r > ${log_file} 2>&1

diff ${log_file} ${data_dir}/expected_output.txt > ${OUTPUT_DIR}/coreutils/tmp.txt

# Check result of command sort with expected output
if [ -s ${OUTPUT_DIR}/coreutils/tmp.txt ]
then
  echo "${test_failed_text}" >> ${RESULT_FILE}
else
  echo "${test_passed_text}" >> ${RESULT_FILE}
fi

# Remove a tmp.txt file temp for testing
rm ${OUTPUT_DIR}/coreutils/tmp.txt
