#!/bin/bash
#==============================================================================
# DISCRIPTION: Test script is test to 'tee' command.
#              In test script 'tee' command read contents of 'ls /usr' command
#              and write to sample.txt file.
#==============================================================================
# Remove sample.txt if existed
rm -f sample.txt

# Read contents of "ls /usr" command and write to sample.txt file
ls /usr/ | tee sample.txt > ${log_file} 2>&1

# Check result of command tee with expected output
diff ${log_file} sample.txt > ${OUTPUT_DIR}/coreutils/tmp.txt

if [ -s ${OUTPUT_DIR}/coreutils/tmp.txt ]
then
  echo "${test_failed_text}" >> ${RESULT_FILE}
else
  echo "${test_passed_text}" >> ${RESULT_FILE}
fi

# Remove a tmp.txt file temp for testing
rm ${OUTPUT_DIR}/coreutils/tmp.txt sample.txt
