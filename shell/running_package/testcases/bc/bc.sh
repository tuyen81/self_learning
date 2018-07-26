#!/bin/bash

#===============================================================================
# DESCRIPTION: Test some calculations then check result of output
#===============================================================================

# Test bc command with some calculations
sed -e 's/\s*\(.*\).*/\1/' << EOF | bc >> ${PWD}/bc.txt 2>&1
121+19
sqrt(121)
50>150
EOF

cat ${PWD}/bc.txt > ${log_file}

diff ${PWD}/bc.txt ${data_dir}/output_expected.txt >> ${log_file} 2>&1

# Check result of testcase
assert_passed $? 0

# Delete non-necessary file after run test
rm ${PWD}/bc.txt
