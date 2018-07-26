#!/bin/bash
#==============================================================================
# DESCRIPTION: join.sh is used to test 'join' command of coreutils package
#              1. Create two file having common field, and expected output file
#              2. Use join command to create joint file
#              3. Compare joint file and expected output file, update result to
#              result.txt file
#==============================================================================
# 1. Create input file
printf "1 File1-1\n2 File1-2\n3 File1-3\n5 File1-5\n4 File1-4\na File1-a" > ${data_dir}/file1.txt

printf "1 File2-1\n2 File2-2\n3 File2-3\n5 File2-5\n4 File2-4\na File2-A" > ${data_dir}/file2.txt

# 2. Create expected file
printf "1 File1-1 File2-1\n2 File1-2 File2-2\n3 File1-3 File2-3\n5 File1-5 File2-5\n4 File1-4 File2-4\na File1-a File2-A\n" > ${log_file}

# 3. Run command
join --nocheck-order -i  ${data_dir}/file1.txt ${data_dir}/file2.txt > ${data_dir}/join.txt 2>&1

# 4. Generate result
diff  ${data_dir}/join.txt ${log_file} > /dev/null 2>&1

assert_passed $? 0
