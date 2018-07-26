#!/bin/bash

#==============================================================================
# DESCRIPTION: Create embed xsinit.c file using perl
#==============================================================================

echo "Testing perl-module-extutils-embed" > ${log_file}

check=0
# Create xsinit.c file using perl
perl -MExtUtils::Embed -e xsinit -- -o xsinit.c Socket > ${PWD}/embed.txt 2>&1

diff ${PWD}/xsinit.c ${data_dir}/expected.output >> ${log_file} 2>&1

assert_passed $? 0

cat xsinit.c >> ${log_file} 2>&1

# Remove noneeded file
rm ${PWD}/embed.txt

# Remove unneeded file
rm xsinit.c
