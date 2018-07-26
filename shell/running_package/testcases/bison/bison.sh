#!/bin/bash

#==============================================================================
# DESCRIPTION: Testing for bison command.
#              The bison command is used to parse a *.ypp file 
#              and generate a sample.ypp file.
#==============================================================================

check=0
bison ${data_dir}/sample.ypp > ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

if [ ! -f sample.tab.cpp ]; then
  check=1
fi

assert_passed $check 0

rm -rf sample.tab.cpp
