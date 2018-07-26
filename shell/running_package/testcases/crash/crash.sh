#!/bin/sh
#
#=======================================================================
# DESCRIPTION: Test for crash package 
# PRECONDITION: Need run as root
#=======================================================================

debug_kernel="/usr/lib/debug/vmlinux-3.16.0-4-amd64"
system_map="/boot/System.map-3.16.0-4-amd64"
commands_file="${data_dir}/commands.txt"
crash_commands=(alias dev files ipcs irq mod mount net ps set sig swap sys timer vm)

if [ ! -f "$debug_kernel" ]; then
  echo "You don't have a debug kernel." > ${log_file}
  echo "Please create a debug kernel or install package linux-image-*-dbg."  >> ${log_file}
  echo "Then update path to debug kernel in ${TESTCASES_DIR}/${package_name}" >> ${log_file}
  exit 1
fi

test -d ${data_dir} || mkdir -p ${data_dir}

# Prepare a commands list to run with crash
echo "" > $commands_file
for cmd in ${crash_commands[@]}; do
  echo "$cmd > ${data_dir}/result_${cmd}.txt" >> $commands_file
done
echo exit >> $commands_file

# This command to run crash's commands
crash $debug_kernel $system_map -i $commands_file >> ${log_file} 2>&1

# Expected value when run test
expected_alias="ORIGIN\s+ALIAS\s+COMMAND"
expected_dev="CHRDEV\s+NAME\s+CDEV\s+OPERATIONS" 
expected_files="PID:.+TASK:.+CPU:.+COMMAND: \"crash\""
expected_ipcs="SHMID_KERNEL\s+KEY\s+SHMID\s+UID\s+PERMS BYTES\s+NATTCH STATUS"
expected_irq="IRQ\s+IRQ_DESC/_DATA\s+IRQACTION\s+NAME"
expected_mod="MODULE\s+NAME\s+SIZE\s+OBJECT\s+FILE"
expected_mount="MOUNT\s+SUPERBLK\s+TYPE\s+DEVNAME\s+DIRNAME"
expected_net="NET_DEVICE\s+NAME\s+IP ADDRESS\(ES\)"
expected_ps="PID\s+PPID\s+CPU\s+TASK\s+ST\s+%MEM\s+VSZ\s+RSS\s+COMM"
expected_set="COMMAND: \"crash\""
expected_sig="PID:.+TASK:.+CPU:.+COMMAND: \"crash\""
expected_swap="SWAP_INFO_STRUCT\s+TYPE\s+SIZE\s+USED\s+PCT\s+PRI\s+FILENAME"
expected_sys="DEBUG KERNEL: $debug_kernel"
expected_timer="EXPIRES\s+TIMER_LIST\s+FUNCTION"
expected_vm="PID:.+TASK:.+CPU:.+COMMAND: \"crash\""

check=0
for cmd in ${crash_commands[@]}; 
do
  expected_var="expected_$cmd"
  expected_value=${!expected_var}

  grep -E "$expected_value" ${data_dir}/result_${cmd}.txt >> ${log_file} 2>&1
  if [ $? -ne 0 ]; then
    echo "Command $var failed!" >> ${log_file}
    check=1
  fi
done

assert_passed $check 0

rm -rf ${data_dir}
