#!/bin/bash
#==============================================================================
# DESCRIPTION: kmod.sh tests kmod command of kmod package.
#              Run kmod command to list the currently loaded modules to stdout
#              Search a key word in output to verify result
#==============================================================================
#List currently loaded module and check output
kmod list > ${log_file} 2>&1

#check output
grep -nr "Module" ${lod_file} > /dev/null 2>&1

assert_passed $? 0
