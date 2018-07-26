TGTDEV=`fdisk -l| grep sd | grep -v vda| sed 's/:.*//'|cut -d' ' -f2-`

# Define a partition where file system was stored: /dev/vda, /dev/sda, /dev/mmcblk
FILE_SYSTEM_PARTITION=/dev/vda
