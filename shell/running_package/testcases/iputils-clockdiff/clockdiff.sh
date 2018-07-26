#!/bin/bash

#==============================================================================
# DESCRIPTION: Testing for clockdiff command.
#              It use the clockdiff command to measure clock difference between hosts.
#              It check the clockdiff command be able to run successful or not.
#==============================================================================

clockdiff -o localhost > ${log_file} 2>&1

assert_passed $? 0
