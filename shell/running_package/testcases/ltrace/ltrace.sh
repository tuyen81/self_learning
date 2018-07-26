#!/bin/bash
#==============================================================================
# DESCRIPTION: ltrace.sh tests ltrace command of ltrace package
#              Ltrace simply runs the specified command until it exits.
#              Run ltrace command to records the dynamic library calls which are
#              called by the executed process and the signals which are received
#              by that process
#==============================================================================
ltrace echo "hello" > ${log_file} 2>&1

assert_passed $? 0
