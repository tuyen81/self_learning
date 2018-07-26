# Format device
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk ${TGTDEV}
  d # delete a partition
  p # print the in-memory partition table
  w # write the partition table
  q # and we're done
EOF
