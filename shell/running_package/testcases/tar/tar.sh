#!/bin/bash

#===============================================================================
# DESCRIPTION: Compress two .tct files to one  .tar.gz file
#              Decompress .tar.gz file above and check content after decompress 
#===============================================================================

mkdir tar_test tar; cd tar_test

# Test compress file
touch tmp1.txt tmp2.txt

tar -czf ${PWD}/../tar/tmp.tar.gz tmp1.txt tmp2.txt

ls ${PWD}/../tar > ${OUTPUT_DIR}/tar/tar.log 2>&1

diff ${OUTPUT_DIR}/tar/tar.log ${data_dir}/output_expected_compress.txt > ${PWD}/../compress

# Test decompress file
rm tmp1.txt tmp2.txt

tar -xzf ${PWD}/../tar/tmp.tar.gz

ls > ${OUTPUT_DIR}/tar/tar.log 2>&1

diff ${OUTPUT_DIR}/tar/tar.log ${data_dir}/output_expected_decompress.txt >> ${PWD}/../compress

# Get result of testcase 
if [ -s ${PWD}/../compress ]; then
  echo "${test_failed_text}" >> ${RESULT_FILE}
else
  echo "${test_passed_text}" >> ${RESULT_FILE}
fi
cd .. 

# Delete non-necessary file and folder
rm -r tar_test tar compress
