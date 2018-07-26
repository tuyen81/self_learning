#!/bin/bash

#===============================================================================
# DESCRIPTION: Generate quality controllable random passphrase with pwqgen then
#              check passphrase quality with pwqcheck
#===============================================================================

check=0

# Generate quality controllable random passphrase
pwqgen > ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check passphrase with quality
echo Hello123 | pwqcheck -1 | grep "Bad passphrase (not enough different characters or classes for this length)" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

# Check passphrase high quality
echo HelloWorld123456 | pwqcheck -1 | grep "OK" >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi

assert_passed $check 0
