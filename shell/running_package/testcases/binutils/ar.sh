#!/bin/bash

#==============================================================================
# DESCRIPTION: Testing for ar command.
#              The ar command is used to extracts a archive file 
#              and check list file in the archive file.
#==============================================================================

ar -t ${data_dir}/bc_1.06.95-9_i386.deb > ${log_file} 2>&1

diff ${log_file} ${data_dir}/expected_output >> ${log_file} 2>&1

assert_passed $? 0
