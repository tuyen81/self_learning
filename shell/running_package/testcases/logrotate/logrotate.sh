#!/bin/bash
#==============================================================================
# DESCRIPTION: logrotate.sh tests "logrotate" command of logrotate package.
#              Use logrotate to compress input file
#              First, we create sample testlog file, then run logrotate command 
#              using this input testlog.
#==============================================================================
touch testlog
cat <<EOF > testlog
rotate 4
/var/log/testlog.log {
    missingok
    notifempty
    compress
    size 10k
    daily
    create 0600 root root
}
EOF

#Create file "testlog.log"
echo "Test log" > /var/log/testlog.log

#Run command logrotate
logrotate -f testlog > ${log_file} 2>&1

if [ $? = "0" ]
then
  ls /var/log/ | grep testlog.log.1.gz > /dev/null 2>&1
  assert_passed $? 0  
else
  echo ${test_failed_text} >> ${RESULT_FILE}
fi
rm -f testlog
