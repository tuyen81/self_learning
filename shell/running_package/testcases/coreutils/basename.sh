#!/bin/bash

#==============================================================================
# DESCRIPTION: Testing for basename command.
#              The basename command is used to strip directory and suffix from 
#              include/stdio.h filename.
#==============================================================================

basename /usr/bin/toshiba > ${OUTPUT_DIR}/${package_name}/tmp.log 2>&1
cp ${OUTPUT_DIR}/${package_name}/tmp.log ${log_file} 2>/dev/null

check=0
s="toshiba"
if [ "$s" != "$(cat ${OUTPUT_DIR}/${package_name}/tmp.log)" ] ;then
  check=1
fi

ss="stdio"
basename include/stdio.h .h > ${OUTPUT_DIR}/${package_name}/tmp.log 2>&1
cat ${OUTPUT_DIR}/${package_name}/tmp.log >> ${log_file}
if [ "$ss" != "$(cat ${OUTPUT_DIR}/${package_name}/tmp.log)" ] ;then
  check=1
fi

assert_passed $check 0

rm -rf ${OUTPUT_DIR}/${package_name}/tmp.log
