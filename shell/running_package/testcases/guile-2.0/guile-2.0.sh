#!/bin/sh
#
#======================================================
# DESCRIPTION: Create test script for guile-2.0 package
#======================================================

# Run commands of guile-2.0 package in file guile-2.0_command.txt
guile-2.0 < ${data_dir}/guile-2.0_command.txt > ${log_file}
# Expected value when run test
expected1="\$1 = 3"
expected2="\$2 = 10"
expected3="\$3 = (2 3 4)"
expected4="\$4 = 120"
expected5="\$5 = 8"
expected6="\$6 = \"Hello Guile-2.0\""
expected7="\$7 = (1 2 3 4)"
expected8="\$8 = (4 1 2 3)"
expected9="\$9 = #f"
expected10="\$10 = #f"
expected11="\$11 = \"This is true\""
expected12="\$12 = Oke"
expected13="\$13 = (0 1 2 3 4 5 6 7 8 9)"

# Output value when run test
output1=$(grep -e "$expected1" ${log_file})
output2=$(grep -e "$expected2" ${log_file})
output3=$(grep -e "$expected3" ${log_file})
output4=$(grep -e "$expected4" ${log_file})
output5=$(grep -e "$expected5" ${log_file})
output6=$(grep -e "$expected6" ${log_file})
output7=$(grep -e "$expected7" ${log_file})
output8=$(grep -e "$expected8" ${log_file})
output9=$(grep -e "$expected9" ${log_file})
output10=$(grep -e "$expected10" ${log_file})
output11=$(grep -e "$expected11" ${log_file})
output12=$(grep -e "$expected12" ${log_file})
output13=$(grep -e "$expected13" ${log_file})

check=0
for var in 1 2 3 4 5 6 7 8 9 10 11 12 13
do
  expected_var="expected$var"
  output_var="output$var"
  expected_value=${!expected_var}
  output_value=${!output_var}

if [ "$expected_value" = "" ]; then
  echo "$expected_var was not defined!" >> ${log_file}
  check=1
elif [ "$expected_value" != "$output_value" ]; then
  echo "Wrong output! Expected: $expected_value, Actual: $output_value" >> ${log_file}
  check=1
fi
done

assert_passed $check 0
