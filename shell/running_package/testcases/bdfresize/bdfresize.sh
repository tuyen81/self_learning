#!/bin/sh
#
#=======================================================================
# DESCRIPTION: Test for the bdf file is resize when run command bdfresize
#=======================================================================

check=0

sample_font=${data_dir}/sample.bdf
factor=2/1
size_before=$(grep "^PIXEL_SIZE " $sample_font | cut -d' ' -f2)
size_after_expect=$(($size_before * $factor))

bdfresize -f $factor $sample_font > ${log_file} 2>&1
if [ $? != 0 ]; then
	echo "[FAIL] bdfresize failed to run!" >> ${log_file}
	check=1
fi

size_after=$(grep "^PIXEL_SIZE " $log_file | cut -d' ' -f2)
if [ "$size_after" != "$size_after_expect" ]; then
	echo "[FAIL] Resize to wrong size!" >> ${log_file}
	check=1
fi

assert_passed $check 0
