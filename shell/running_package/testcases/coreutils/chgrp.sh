#!/bin/bash

#==============================================================================
# DESCRIPTION: Testing for chgrp command.
#              The chgrp command is used to change group ownership of a file
#==============================================================================

check=0
# Create group "toshiba"
groupadd toshiba

cp ${data_dir}/sample_chgrp.txt ${data_dir}/sample_chgrp.txt.bak
# Change group ownership of sample_chgrp.txt
chgrp toshiba ${data_dir}/sample_chgrp.txt > ${log_file} 2>&1

if [ -s ${log_file} ]; then
  check=1
fi

ls -l ${data_dir}/sample_chgrp.txt >> ${log_file} 2>&1

grep -nr toshiba ${log_file} > /dev/null 2>&1

if [ $? != "0" ]; then
  check=1
fi

assert_passed $check 0

mv ${data_dir}/sample_chgrp.txt.bak ${data_dir}/sample_chgrp.txt
groupdel toshiba
