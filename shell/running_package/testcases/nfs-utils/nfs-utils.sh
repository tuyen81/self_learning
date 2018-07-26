#!/bin/bash

#==============================================================================
# DESCRIPTION: Start and stop nfs-kernel-server service, create folder and mount
#              Show mount information and unmount folder
#==============================================================================

check=0

# backup hosts.deny, hosts.allow and exports file
cp /etc/hosts.deny /etc/hosts.deny.bak 2> ${log_file}
cp /etc/hosts.allow /etc/hosts.allow.bak 2>> ${log_file}
cp /etc/exports /etc/exports.bak 2>> ${log_file}

# Add content to hosts.deny, hosts.allow and exports file
echo "ALL: ALL" >> /etc/hosts.deny
echo "ALL: 127.0.0.1" >> /etc/hosts.allow
echo "/usr *(rw,no_root_squash,no_subtree_check,crossmnt,fsid=0)" >> /etc/exports

# Export NFS file system and restart rpcbind service
exportfs -ra >> ${log_file} 2>&1
/etc/init.d/rpcbind restart >> ${log_file} 2>&1
/etc/init.d/rpcbind status >> ${log_file} 2>&1

# Create directory nfs_mount_dir for testing
mkdir -p nfs_mount_dir
systemctl stop nfs-kernel-server >> ${log_file} 2>&1
systemctl status -l nfs-kernel-server >> ${log_file} 2>&1

# Start nfs-server service
systemctl start nfs-kernel-server 2>> ${log_file}
systemctl status -l nfs-kernel-server | grep "Active: active (running)" >> ${log_file} 2>&1

if [ $? -ne 0 ];then
  check=1
fi

# Show mount information
showmount -e 127.0.0.1 > ${PWD}/export
diff ${PWD}/export ${data_dir}/export >> ${log_file} 2>&1

if [ $? -ne 0 ];then
  check=1
fi

# Mount NFS file system
mount.nfs -o nolock 127.0.0.1:/usr nfs_mount_dir >> ${log_file} 2>&1

if [ $? -ne 0 ];then
  check=1
fi

# Check if NFS file system was mounted or not
mount | grep "nfs_mount_dir" >> ${log_file} 2>&1

if [ $? -ne 0 ];then
  check=1
fi

# Stop nfs-server service
systemctl stop nfs-kernel-server 2>> ${log_file}
systemctl status -l nfs-kernel-server | grep "Active: inactive (dead)" >> ${log_file} 2>&1

if [ $? -ne 0 ];then
  check=1
fi

# start nfs-common service
systemctl start nfs-common 2>> ${log_file}
systemctl status -l nfs-common | grep "Active: active (running)" >> ${log_file} 2>&1

if [ $? -ne 0 ];then
  check=1
fi

# Check result of testcase
assert_passed $check 0

# Remove unneeded file and revert by default
mv /etc/hosts.deny.bak /etc/hosts.deny
mv /etc/hosts.allow.bak /etc/hosts.allow
mv /etc/exports.bak /etc/exports

umount.nfs 127.0.0.1:/usr nfs_mount_dir
rm -r nfs_mount_dir ${PWD}/export
