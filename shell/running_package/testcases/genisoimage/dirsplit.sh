#!/bin/bash
#
#==============================================================================
# DESCRIPTION: Testing for dirsplit command.
#              Split "sampledir" folder containing some files totaling more 
#              than 2MB into individual directories of 2MB each.
#==============================================================================

echo "Testing dirsplit" > ${log_file}

sampledir="$PWD/sampledir"
mkdir -p $sampledir
dd if=/dev/zero of=$sampledir/file1 bs=1k count=500 >> ${log_file} 2>&1
cp $sampledir/file1 $sampledir/file2

# Split "sampledir" folder.
dirsplit --size 1M --expmode 1 $sampledir >> ${log_file} 2>&1
ls vol_1.list vol_2.list >> ${log_file} 2>&1

# Check result of testcase
assert_passed $? 0

rm -rf vol_1.list vol_2.list $sampledir
