#!/bin/bash
#
#==============================================================================
# DESCRIPTION: Testing for dnsmasq command.
#              Start, stop and restart dnsmasq service then check 
#              result.
#              Read and syntax check configuration files.
#==============================================================================

check=0
echo "Testing dnsmasq" > ${log_file}

# Change default port to avoid conflict with bind9
cp /etc/dnsmasq.conf /etc/dnsmasq.conf.bak
cp ${data_dir}/dnsmasq.conf /etc/dnsmasq.conf

# Start dnsmasq service
service dnsmasq start >> ${log_file} 2>&1
if [ $? -ne 0 ]; then
  check=1
fi

# Restart dnsmasq service
service dnsmasq restart >> ${log_file} 2>&1
if [ $? -ne 0 ]; then
  check=1
fi

# Stop dnsmasq service
service dnsmasq stop >> ${log_file} 2>&1
if [ $? -ne 0 ]; then
  check=1
fi

# Read and syntax check configuration files
dnsmasq --test >> ${log_file} 2>&1
if [ $? -ne 0 ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0

# Restore config
mv /etc/dnsmasq.conf.bak /etc/dnsmasq.conf
