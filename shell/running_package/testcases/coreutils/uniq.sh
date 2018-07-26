#!/bin/bash
#==============================================================================
# DISCRIPTION: Test script is test to 'uniq' command.
#              The 'uniq' command used to filters out repeated lines in a sample.txt file.
#              The sample.txt file has been stored contents 'aa\n aa\n bb\n bb\n bb\n cc\'.
#==============================================================================

# Declare expected output number word repeated in sample.txt file
EXPECTED_WORD_AA="2 aa"
EXPECTED_WORD_BB="3 bb"
EXPECTED_WORD_AA="1 cc"

# Run "uniq" command to filters out repeated lines in a sample.txt file
uniq -c ${data_dir}/sample.txt > ${log_file} 2>&1

# Check result of command uniq with expected output
if [ -n "`cat ${OUTPUT_DIR}/coreutils/uniq.log | grep "${EXPECTED_WORD_AA}"` && `cat ${OUTPUT_DIR}/coreutils/uniq.log | grep "${EXPECTED_WORD_BB}"` && `cat ${OUTPUT_DIR}/coreutils/uniq.log | grep "${EXPECTED_WORD_CC}"`" ]
then
  echo "${test_passed_text}" >> ${RESULT_FILE}
else
  echo "${test_failed_text}" >> ${RESULT_FILE}
fi
