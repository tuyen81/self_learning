#!/bin/bash
#==============================================================================
# DESCRIPTION: cut.sh tests 'cut' command of coreutils package
#              The 'cut' command  to cut parts of a line by byte position,
#              character and delimiter
#              Use 'cut' command to cut input string 'Hello world' then the output
#              is printed to stdout after cutting
#              The actual output is compared with expected output to give result.
#==============================================================================
#create expected output file to compare
echo "Hello" > expected_output1.txt 2>&1
echo "world" > expected_output2.txt 2>&1
#Cut input string from first to fifth character
echo "Hello world" | cut -c1-5 > ${log_file} 2>&1
#check expected output and real output
diff ${log_file} expected_output1.txt > /dev/null 2>&1
if [ $? = "0" ]
then
  #print all character after space
  echo "Hello world" | cut -d" " -f2 > ${log_file} 2>&1
  #check expected output and real output
  diff ${log_file} expected_output2.txt > /dev/null 2>&1
  assert_passed $? 0
else
  echo ${test_failed_text} >> ${RESULT_FILE}
fi
rm -f expected_output1.txt expected_output2.txt
