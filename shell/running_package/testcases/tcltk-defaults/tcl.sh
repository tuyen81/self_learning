#!/bin/bash

#==============================================================================
# DESCRIPTION: Read Tcl command from sample.tcl file then run
#==============================================================================


check=0
echo "Testing tcl" > ${log_file}

cat <<EOF> sample.tcl
set greeting hello
puts \$greeting

set addressee world
puts "\$greeting, \$addressee"
EOF

# Read Tcl command and run
tclsh sample.tcl > ${PWD}/sample.txt 2>&1

diff ${PWD}/sample.txt ${data_dir}/output_expected.txt >> ${log_file} 2>&1

assert_passed $? 0

# Remove noneeded file
rm ${PWD}/sample.*
