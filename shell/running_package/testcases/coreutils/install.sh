#!/bin/bash
#==============================================================================
# DESCRIPTION: install.sh is used to test install command of coreutils package
#              First, The install command install sample.sh script file.
#              Second, run binary file to show result. The script prints
#              'Hello world' to stdout
#              After running install sample.sh script. Run binary file
#              and compare real output to expected output to veriry result
#==============================================================================
#Create input sample script for install command
echo "echo "Hello world"" > sample.sh

#Create expected output to compare result
echo "Hello world" > expected_result.txt

#run command install
install sample.sh /usr/bin/helloworld > /dev/null 2>&1

#run binary file
helloworld > ${log_file} 2>&1

#compare output to expected result
diff ${log_file} expected_result.txt 2>&1

assert_passed $? 0

rm -f expected_result.txt sample.sh
