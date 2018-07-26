#!/bin/bash
#==============================================================================
# DISCRIPTION: Create, verify and show new key
#              use openssl command with option parameter corresponding
#              The actual output is compared with expected output to give result. 
#==============================================================================

check=0

# Declare variable expected output
GENERATING_KEY="Generating a 1024 bit RSA private key"
VERIFY_KEY="verify OK"
CERTIFICATE_REQUEST="Public Key Algorithm: rsaEncryption"

# Run command to create new key
sed -e "s/\s.*\(.*\).*/\1/" << EOF | openssl req -new -newkey rsa:1024 -nodes -keyout mykey.pem -out myreq.pem > ${log_file} 2>&1









EOF

# Check has been created new key
grep "${GENERATING_KEY}" ${log_file} > gen_log
if [ $? != "0" ]; then
  check=1
fi

cat gen_log >> ${log_file} 2>&1
rm gen_log

# Run command to verify created key
openssl req -in myreq.pem -noout -verify -key mykey.pem >> ${log_file} 2>&1

# Check verify created key
grep "${VERIFY_KEY}" ${log_file} > ver_log
if [ $? != "0" ]; then
  check=1
fi

cat ver_log >> ${log_file} 2>&1
rm ver_log

# Run command to show the key
openssl req -in myreq.pem -noout -text >> ${log_file} 2>&1

# Check show the key
grep "${CERTIFICATE_REQUEST}" ${log_file} > cer_log
if [ $? != "0" ]; then
  check=1
fi

cat cer_log >> ${log_file} 2>&1
rm cer_log

#Check result of command openssl with expected output
assert_passed $check 0

# Remove unneeded file
rm -rf mykey.pem myreq.pem
