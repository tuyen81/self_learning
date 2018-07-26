#!/bin/bash
# author: datnd
#========================================================================================
# DESCRIPTION: Testing for checking number of processing units available by nproc command
#========================================================================================

# run step 1
nproc > ${log_file} 2> ${log_file}

assert_passed $? 0
