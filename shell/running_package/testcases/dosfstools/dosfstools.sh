#!/bin/sh
#
#======================================================
# DESCRIPTION: Create test script for dosfstools package
#======================================================

check=0

label="TEST LABEL"
img_file="${PWD}/image.img"
dd if=/dev/zero of=$img_file bs=1k count=1024 > ${log_file} 2>&1

# /sbin/mkfs.vfat, /sbin/mkfs.msdos, /sbin/mkdosfs are just a symlink to /sbin/mkfs.fat
mkfs.fat $img_file >> ${log_file} 2>&1

if [ $? != 0 ]; then
	echo "mkfs.fat: failed!" >> ${log_file} 2>&1
	check=1
fi

# /sbin/dosfsck, /sbin/fsck.msdos, /sbin/fsck.vfat are just a symlink to /sbin/fsck.fat
fsck.fat $img_file >> ${log_file} 2>&1

if [ $? != 0 ]; then
	echo "fsck.fat: failed!" >> ${log_file} 2>&1
	check=1
fi

# /sbin/dosfslabel is just a symlink to /sbin/fatlabel
fatlabel $img_file "$label" >> ${log_file} 2>&1

if [ $? != 0 ]; then
	echo "fatlabel: cannot set label!" >> ${log_file} 2>&1
	check=1
fi

# get label return label with trailing spaces, strip them
actual_label=`fatlabel $img_file | sed 's/[ ]*$//'`
expect_label=`echo "$label" | sed 's/[ ]*$//'`
if [ "$actual_label" != "$expect_label" ]; then
	echo "fatlabel: label set not correct!" >> ${log_file} 2>&1
	check=1
fi

assert_passed $check 0

rm -f $img_file
