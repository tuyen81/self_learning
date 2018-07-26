#!/bin/bash
# author: datnd
#===================================================================================
# DESCRIPTION: Testing for printing name of current/working directory by pwd command
#===================================================================================

EXP_OUTPUT="\/usr\/lib"

# run step 1
cd /usr/lib/

# run step 2
OUTPUT_STEP=`pwd` 2> ${log_file}

echo -e "OUTPUT_STEP:\n""${OUTPUT_STEP}" >> ${log_file}

grep "${EXP_OUTPUT}" ${log_file} &> /dev/null

assert_passed $? 0

cd - > /dev/null 2>&1
