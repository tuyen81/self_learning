#!/bin/bash

#==============================================================================
# DESCRIPTION: Create sample.pl file using strict module then run sample.pl
#              using perl. Get output message follow perl-module-strict
#==============================================================================

echo "Testing perl-module-strict" > ${log_file}

check=0
# Create sample.pl file for testing with content as below
cat <<EOF> sample.pl
#!/usr/bin/perl
    use strict 'refs';
    \$ref = \\\$foo;
    print \$\$ref;	# ok
    \$ref = "foo";
    print \$\$ref;	# runtime error; normally ok
EOF

# Run sample.pl file using perl
perl sample.pl 2>> ${log_file} | grep "Can't use string ("foo") as a SCALAR ref while "strict refs" in use at strict line 6" >> ${log_file} 2>&1

if [ $? -eq 0 ]; then
  check=1
fi

# Delete line 5 in sample.pl file
sed -i '/"foo"/d' sample.pl 2>> ${log_file}

# Run sample.pl file using perl
perl sample.pl >> ${log_file} 2>&1

if [ $? -ne 0 ]; then
  check=1
fi 

# Check result of testcase
assert_passed $check 0

# Remove noneeded file
rm sample.pl
