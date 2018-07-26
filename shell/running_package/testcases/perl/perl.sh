#!/bin/bash

#==============================================================================
# DESCRIPTION: Run a perl script with the 'perl' command.
#              The perl script prints 'Hello world' to stdout   
#==============================================================================

EXPECTED_OUTPUT="Hello world"

perl ${data_dir}/sample.pl > ${log_file} 2>&1

grep "${EXPECTED_OUTPUT}" ${log_file} > /dev/null 2>&1

assert_passed $? 0
