#!/bin/bash
#==============================================================================
# DESCRIPTION: Testing for fold command of coreutils package.
#              Use fold command to Wrap input lines in each FILE and 
#              write to standard output
#              First, Create input file for fold command, then run fold command
#              with this input file. Compare output result to expected result
#              to show test case pass or fail
#==============================================================================
# Create expect_result file for comparing
cat <<EOF> expect_result
Hello
 worl
d
EOF
# Create file sample.txt for testing
echo "Hello world" > sample.txt
fold -w 5 sample.txt > ${log_file} 2>&1

#Compare expected result and output
diff expect_result ${log_file} > ${OUTPUT_DIR}/coreutils/tmp.log 2>&1

assert_passed $? 0

cat ${OUTPUT_DIR}/coreutils/tmp.log >> ${log_file} 2>&1

rm -f expect_result sample.txt
