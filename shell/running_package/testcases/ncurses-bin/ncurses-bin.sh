#!/bin/bash
#==============================================================================
# DISCRIPTION: Testing for clear command.
#              The 'clear' command will clear terminal screen 
#              Run clear command and check status by $?.
#==============================================================================

# Clear the terminal
clear > ${log_file} 2>&1

assert_passed $? 0
