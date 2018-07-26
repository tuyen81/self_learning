#!/bin/bash
#==============================================================================
# DISCRIPTION: Testing for cp command.
#              In test script cp command used to make copies directory "testing_cp_command" to "/root".
#==============================================================================
# Create folder for testing
rm -fr testing_cp_command
mkdir -p testing_cp_command

# Copy directory "testing_cp_command" to "/root" use "cp" command
cp -r testing_cp_command /root/ > ${log_file} 2>&1
# Check result of command cp with expected output
if [ "find /root -name "testing_cp_command"" ]
then
  echo "${test_passed_text}" >> ${RESULT_FILE}
else
  echo "${test_failed_text}" >> ${RESULT_FILE}
fi
# Remove directory "testing_cp_command" in "/root"
rm -r /root/testing_cp_command testing_cp_command
