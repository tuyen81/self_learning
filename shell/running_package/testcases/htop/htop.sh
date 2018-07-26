#!/bin/sh
# author: datnd
#================================================================================================================
# DESCRIPTION: Testing for interactive process viewer
#================================================================================================================

# run command to test
sed -e "s/\s.*\(.*\).*/\1/" << EOF | htop > htop.txt
q
EOF

assert_passed $? 0

# Remove non-necessary file
rm htop.txt
