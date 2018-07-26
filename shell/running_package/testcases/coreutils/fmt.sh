#!/bin/bash
#==============================================================================
# DESCRIPTION: Testing for fmt command.
#              Use fmt command to Reformat each paragraph in the FILE(s),
#              writing to standard output
#              First, Create input file sample.txt, then run fmt command using
#              sample.txt file
#              Compare output result to expected output to check result
#==============================================================================
# Create expect_result file for comparing
cat <<EOF> expect_result
Line 1 Line 2 Line 3
Line 4 Line 5 Line 6
Line 7
EOF

# Create file sample.txt for testing
cat <<EOF> sample.txt
Line 1
Line 2
Line 3 
Line 4
Line 5
Line 6
Line 7
EOF

#Run command
fmt -w 22 sample.txt > ${log_file}

#Compare expected result and output
diff expect_result ${log_file} > ${OUTPUT_DIR}/coreutils/tmp.log 2>&1

assert_passed $? 0

cat ${OUTPUT_DIR}/coreutils/tmp.log >> ${log_file} 2>&1

rm -f expect_result sample.txt ${OUTPUT_DIR}/coreutils/tmp.log
