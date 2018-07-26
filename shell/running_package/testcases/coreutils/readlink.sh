#!/bin/bash
# author: datnd
#===================================================================================================================
# DESCRIPTION: Testing for printing canonical path name for file which is linked to /usr/include by readlink command
#===================================================================================================================

EXP_OUTPUT="\/usr\/include"

# run step 1
ln -s /usr/include samplelink

# run step 2
OUTPUT_STEP=`readlink samplelink` 2> ${log_file}

echo -e "OUTPUT_STEP:\n""${OUTPUT_STEP}" >> ${log_file}

grep "${EXP_OUTPUT}" ${log_file} &> /dev/null

assert_passed $? 0

# clean unneeded output after testting
rm samplelink
