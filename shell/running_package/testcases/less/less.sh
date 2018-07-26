#!/bin/bash
#==============================================================================
# DESCRIPTION: less.sh tests less command of less package
#              Use 'less' command to open a file then check opening have 
#              successful or not
#==============================================================================
less ${data_dir}/sample.txt > ${log_file} 2>&1

diff ${log_file} ${data_dir}/sample.txt >> /dev/null 2>&1

assert_passed $? 0
