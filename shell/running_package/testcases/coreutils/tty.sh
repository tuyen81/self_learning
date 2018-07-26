#!/bin/bash
#==============================================================================
# DISCRIPTION: Test script is test to 'tty' command.
#              The 'tty' command prints the name of it's source of its
#              standard input provided that is a terminal
#==============================================================================

# Prints the name of it's source of its standard input provided that is a terminal
tty > ${log_file} 2>&1

# Check result of command tty with expected output
assert_passed $? 0
