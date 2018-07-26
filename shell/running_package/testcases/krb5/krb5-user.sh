#!/bin/bash

#==============================================================================
# DESCRIPTION: Test cache Kerberos ticket and list all cached Kerberos tickets
#==============================================================================

kdc=0
krb5=0
check=0

echo "testing krb5-user" > ${log_file}
# Check /var/krb5.conf existed or not and backup data
if [ -a /etc/krb5.conf ]; then
  mv /etc/krb5.conf /etc/krb5.conf.bak 2>> ${log_file}
  krb5=1
fi

# Check /var/krb5kdc existed or not and backup data
if [ -d /var/krb5kdc ]; then
  mv /var/krb5kdc /var/krb5kdc.bak 2>> ${log_file}
  kdc=1
fi

mv /etc/hosts /etc/hosts.bak >> ${log_file} 2>&1

# Create config file directory for testing
mkdir -p /var/krb5kdc

cp ${data_dir}/kdc.conf /var/krb5kdc/kdc.conf
cp ${data_dir}/krb5.conf /etc/krb5.conf
cp ${data_dir}/hosts.txt /etc/hosts

# Add account to database:
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | kdb5_util create -r EXAMPLE.COM -s > ${PWD}/database.txt 2>&1
1
1
EOF

cat ${PWD}/database.txt >> ${log_file} 2>&1

sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | kadmin.local -q "addprinc root/admin" > ${PWD}/admin.local 2>&1
1
1
EOF

cat ${PWD}/admin.local >> ${log_file} 2>&1

sed -i '/^WARNING: no/d' ${PWD}/admin.local >> ${log_file} 2>&1

diff ${PWD}/admin.local ${data_dir}/krb5-admin-server.expected >> ${log_file} 2>&1

if [ $? -ne 0 ];then
  check=1
fi

# Start krb5-admin-server service
systemctl restart krb5-admin-server
systemctl status -l krb5-admin-server | grep "Active: active (running) " >> ${log_file} 2>&1

if [ $? -ne 0 ];then
  check=1
fi

# Start the Kerberos administration demons
kadmind >> ${log_file} 2>&1

if [ $? -ne 0 ];then
  check=1
fi

# Obtain and cache Kerberos ticket-granting ticket
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | kinit -p root/admin >> ${log_file} 2>&1
1
EOF

(klist | grep "Default principal: root/admin@EXAMPLE.COM")&&(klist | grep "Ticket cache: FILE") >> ${log_file} 2>&1

if [ $? -ne 0 ];then
  check=1
fi

# Check result of testcase
assert_passed $check 0

# Remove unneeded file and revert by default
kdb5_util destroy -r EXAMPLE.COM -f >> ${log_file} 2>&1

rm -rf ${PWD}/admin.local
rm -rf ${PWD}/database.txt
rm -rf /var/krb5kdc
rm /etc/krb5.conf
rm /etc/hosts >> ${log_file} 2>&1

mv /etc/hosts.bak /etc/hosts >> ${log_file} 2>&1

if [ $kdc -eq 1 ]; then
  mv /var/krb5kdc.bak /var/krb5kdc
fi

if [ $krb5 -eq 1 ]; then
  mv /etc/krb5.conf.bak /etc/krb5.conf
fi
