#!/bin/bash
#==============================================================================
# DESCRIPTION: iputils-tracepath.sh tests 'tracepath' command of iputils package.
#              Use 'tracepath' command to traces path to destination discovering
#              Maximum Transmission Unit (MTU) along this path
#              The 'tracepath' reports the Maximum Transmission Unit (MTU)
#              to stdout
#==============================================================================
. ${CONFIG_DIR}/network.sh
#tracepath to another host
tracepath -n "$des_ip_address" > ${log_file} 2>&1

#check output
assert_passed $? 0
