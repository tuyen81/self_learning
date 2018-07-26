#!/bin/bash

#==============================================================================
# DESCRIPTION: Testing for addr2line command.
#              The command will convert addresses into file names and line numbers.
#              It convert 80483fb addresses into a.out object file to line numbers.
#==============================================================================

addr2line -e ${data_dir}/a.out 80483fb > ${log_file} 2>&1

assert_passed $? 0
