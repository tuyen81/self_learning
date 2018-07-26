#!/bin/bash
#==============================================================================
# DISCRIPTION: Test script is test to 'tsort' command.
#              The 'tsort' is a standard command line performs a topological
#              sort on it's input
#==============================================================================

# Run "tsort" command execute topological sort on it's input
tsort ${data_dir}/input.txt > ${log_file} 2>&1

diff ${log_file} ${data_dir}/expected_output.txt > ${OUTPUT_DIR}/coreutils/tmp.txt

# Check result of command tsort with expected output
if [ -s ${OUTPUT_DIR}/coreutils/tmp.txt ]
then
  echo "${test_failed_text}" >> ${RESULT_FILE}
else
  echo "${test_passed_text}" >> ${RESULT_FILE}
fi

# Remove a tmp.txt file temp for testing
rm ${OUTPUT_DIR}/coreutils/tmp.txt
