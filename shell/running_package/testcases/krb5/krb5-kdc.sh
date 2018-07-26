#!/bin/bash

#==============================================================================
# DESCRIPTION: Test create and destroy fucntion of kdb5_util command
#              Using kdb5_util create a database and destroy this database
#==============================================================================

kdc=0
krb5=0
check=0

echo "Testing krb5-kdc" > ${log_file}
# Check krb5kdc existed or not and backup data
if [ -d /var/krb5kdc ]; then
  mv /var/krb5kdc /var/krb5kdc.bak 2>> ${log_file}
  kdc=1
fi

# Check /var/krb5.conf existed or not and backup data
if [ -a /etc/krb5.conf ]; then
  mv /etc/krb5.conf /etc/krb5.conf.bak 2>> ${log_file}
  krb5=1
fi

# Create directory for testing
mkdir -p /var/krb5kdc

cp ${data_dir}/kdc.conf /var/krb5kdc/kdc.conf
cp ${data_dir}/krb5.conf /etc/krb5.conf

# Initialize database:
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | kdb5_util create -r EXAMPLE.COM -s > ${PWD}/database.txt 2>&1
1
1
EOF

cat ${PWD}/database.txt >> ${log_file} 2>&1

diff ${PWD}/database.txt ${data_dir}/kdc_expected.txt >> ${log_file} 2>&1

if [ $? -ne 0 ];then
  check=1
fi

# Start krb5-kdc service
systemctl restart krb5-kdc 2>> ${log_file}
systemctl status -l krb5-kdc | grep "Active: active (running) " >> ${log_file} 2>&1

if [ $? -ne 0 ];then
  check=1
fi

# Start the master KDC
krb5kdc >> ${log_file} 2>&1

if [ $? -ne 0 ];then
  check=1
fi

# Check result of testcase
assert_passed $check 0

# Remove unneeded file and revert by default
kdb5_util destroy -r EXAMPLE.COM -f >> ${log_file} 2>&1

rm -rf ${PWD}/database.txt
rm -rf /var/krb5kdc
rm /etc/krb5.conf

if [ $kdc -eq 1 ]; then
  mv /var/krb5kdc.bak /var/krb5kdc
fi

if [ $krb5 -eq 1 ]; then
  mv /etc/krb5.conf.bak /etc/krb5.conf
fi
