#!/bin/sh
# author: datnd
#=====================================================
# DESCRIPTION: Testing for listing table main ip route
#              Adding ip route
#              Listing ip link, 
#              Listing ip rule
#=====================================================

. ${CONFIG_DIR}/network.sh

RESULT=1
EXP_OUTPUT_STEP_1="proto kernel"
EXP_OUTPUT_STEP_3="BROADCAST,MULTICAST"
EXP_OUTPUT_STEP_4="from all"

# run step 1
OUTPUT_STEP_1=`ip route list table main` 2> ${log_file}
echo "OUTPUT_STEP_1:\n""${OUTPUT_STEP_1}" >> ${log_file}
if [ -n "`echo "${OUTPUT_STEP_1}" | grep "${EXP_OUTPUT_STEP_1}"`" ]
then
  echo "STEP 1 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 1 FAILED" >> ${log_file}
fi

#run step 2
ip route add ${ip_route}/24 dev ${ethernet_interface} >> ${log_file} 2>&1
if [ $? = "0" ]
then
  echo "STEP 2 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 2 FAILED" >> ${log_file}
fi

# run step 3
OUTPUT_STEP_3=`ip link list` 2>> ${log_file}
echo "OUTPUT_STEP_3:\n""${OUTPUT_STEP_3}" >> ${log_file}
if [ -n "`echo "${OUTPUT_STEP_3}" | grep "${EXP_OUTPUT_STEP_3}"`" ]
then
  echo "STEP 3 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 3 FAILED" >> ${log_file}
fi

# run step 4
OUTPUT_STEP_4=`ip rule list` 2>> ${log_file}
echo "OUTPUT_STEP_4:\n""${OUTPUT_STEP_4}" >> ${log_file}
if [ -n "`echo "${OUTPUT_STEP_4}" | grep "${EXP_OUTPUT_STEP_4}"`" ]
then
  echo "STEP 4 PASSED" >> ${log_file}
else
  RESULT=0
  echo "STEP 4 FAILED" >> ${log_file}
fi

# check result after running all steps
assert_passed ${RESULT} 1

#remove added route
ip route del ${ip_route}/24 dev ${ethernet_interface} >> ${log_file} 2>&1
