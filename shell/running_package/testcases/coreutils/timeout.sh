#!/bin/bash
#==============================================================================
# DISCRIPTION: Test script is test to 'timeout' command.
#              In test script 'timeout' command used to time limit when run
#              a sample.sh script print numbers the range from 1 to 5
#==============================================================================

# Set execute permission for file sample.sh
chmod +x ${data_dir}/sample.sh 2> ${log_file}

# Run file sample.sh
timeout 2 ${data_dir}/sample.sh > ${PWD}/timeout.sample 2>&1

cat ${PWD}/timeout.sample > ${log_file} 2>&1

# Check result of command timeout with expected output
diff ${PWD}/timeout.sample ${data_dir}/expected_output.txt >> timeout.txt

if [ -s timeout.txt ]
then
  echo "${test_failed_text}" >> ${RESULT_FILE}
else
  echo "${test_passed_text}" >> ${RESULT_FILE}
fi

rm -f timeout.txt ${PWD}/timeout.sample
