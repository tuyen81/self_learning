#!/bin/bash
#==============================================================================
# DISCRIPTION: Run a sed script with the 'sed' command.
#              The sed script replacing the word 'world' in
#              the sample.txt file to 'every one' in the new file.
#              The actual output is compared with expected output to give result.
#==============================================================================

CONTENTS_FILE="Hello every one"

#Stored contents "Hello world" to sample.txt file
echo "Hello world" > ${data_dir}/sample.txt

#Run command sed, changing "world" in the sample.txt file to "every one" in the new file
sed -i "s/world/every\ one/g" ${data_dir}/sample.txt 2> ${log_file}

#Check result of command sed with expected output
if [ -n "`cat ${data_dir}/sample.txt | grep "${CONTENTS_FILE}"`" ]
then
  echo "${test_passed_text}" >> ${RESULT_FILE}
else
  echo "${test_failed_text}" >> ${RESULT_FILE}
fi
