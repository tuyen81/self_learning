#!/bin/bash

#===============================================================================
# DESCRIPTION: Create sample.xml file with wrong format
#              Using xmlwf command to determine xml format of sample.xml file
#===============================================================================

# Create sample.xml file for testing
cat <<EOF> sample.xml
<note>
  <to>Bob<to>
  <from>Alice</from>
  <heading>Test</heading>
  This is content!
</note>
EOF

# Write output to log file xmlwf.log then compare with standard output to get result
xmlwf sample.xml  > ${log_file} 2>&1

diff ${log_file} ${data_dir}/output_expected.txt > ${PWD}/diff.txt

cat ${PWD}/diff.txt >> ${log_file} 2>&1

if [ -s ${PWD}/diff.txt ]; then
  echo "${test_failed_text}" >> ${RESULT_FILE}
else
  echo "${test_passed_text}" >> ${RESULT_FILE}
fi

# Delete non-necessary file after run test
rm ${PWD}/diff.txt ${PWD}/sample.xml
