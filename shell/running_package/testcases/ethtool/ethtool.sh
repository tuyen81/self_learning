#!/bin/sh
# author: datnd
#====================================================================================
# DESCRIPTION: Testing for get information of ethernet interface by ethtool command
#====================================================================================

. ${CONFIG_DIR}/network.sh

EXP_OUTPUT="firmware-version"

OUTPUT=`ethtool -i $ethernet_interface` 2> ${log_file}
echo "OUTPUT:\n""${OUTPUT}" >> ${log_file}
if [ -n "`echo "${OUTPUT}" | grep "${EXP_OUTPUT}"`" ]
then
  echo ${test_passed_text} >> ${RESULT_FILE}
else
  echo ${test_failed_text} >> ${RESULT_FILE}
fi
