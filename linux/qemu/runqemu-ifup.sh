#!/bin/bash
#
# QEMU network interface configuration script. This utility needs to
# be run as root, and will use the tunctl binary from a native sysroot.
# Note: many Linux distros these days still use an older version of
# tunctl which does not support the group permissions option, hence
# the need to use build system's version.
#
# If you find yourself calling this script a lot, you can add the
# the following to your /etc/sudoers file to be able to run this
# command without entering your password each time:
#
# <my-username> ALL=NOPASSWD: /path/to/runqemu-ifup
# <my-username> ALL=NOPASSWD: /path/to/runqemu-ifdown
#
# If you'd like to create a bank of tap devices at once, you should use
# the runqemu-gen-tapdevs script instead. If tap devices are set up using
# that script, the runqemu script will never end up calling this
# script.
#
# Copyright (c) 2006-2011 Linux Foundation
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

usage() {
	echo "sudo $(basename $0) <uid> <gid>"
}

if [ $EUID -ne 0 ]; then
	echo "Error: This script (runqemu-ifup) must be run with root privileges"
	exit 1
fi

if [ $# -ne 2 ]; then
	usage
	exit 1
fi

USERID="-u $1"
GROUP="-g $2"

TUNCTL=/usr/sbin/tunctl
if [ ! -x "$TUNCTL" ]; then
       echo "Error: Unable to find tunctl binary in '/usr/sbin', please bitbake qemu-helper-native"
	exit 1
fi

TAP=`$TUNCTL -b $GROUP 2>&1`
STATUS=$?
if [ $STATUS -ne 0 ]; then
# If tunctl -g fails, try using tunctl -u, for older host kernels
# which do not support the TUNSETGROUP ioctl
	TAP=`$TUNCTL -b $USERID 2>&1`
	STATUS=$?
	if [ $STATUS -ne 0 ]; then
		echo "tunctl failed:"
		exit 1
	fi
fi

IFCONFIG=`which ip 2> /dev/null`
if [ "x$IFCONFIG" = "x" ]; then
	# better than nothing...
	IFCONFIG=/sbin/ip
fi
if [ ! -x "$IFCONFIG" ]; then
	echo "$IFCONFIG cannot be executed"
	exit 1
fi

IPTABLES=`which iptables 2> /dev/null`
if [ "x$IPTABLES" = "x" ]; then
	IPTABLES=/sbin/iptables
fi
if [ ! -x "$IPTABLES" ]; then
	echo "$IPTABLES cannot be executed"
	exit 1
fi

n=$[ (`echo $TAP | sed 's/tap//'` * 2) + 1 ]
$IFCONFIG addr add 192.168.7.$n/32 broadcast 192.168.7.255 dev $TAP
STATUS=$?
if [ $STATUS -ne 0 ]; then
    echo "Failed to set up IP addressing on $TAP"
    exit 1
fi
$IFCONFIG link set dev $TAP up
STATUS=$?
if [ $STATUS -ne 0 ]; then
    echo "Failed to bring up $TAP"
    exit 1
fi

dest=$[ (`echo $TAP | sed 's/tap//'` * 2) + 2 ]
$IFCONFIG route add to 192.168.7.$dest dev $TAP
STATUS=$?
if [ $STATUS -ne 0 ]; then
    echo "Failed to add route to 192.168.7.$dest using $TAP"
    exit 1
fi

# setup NAT for tap0 interface to have internet access in QEMU
$IPTABLES -A POSTROUTING -t nat -j MASQUERADE -s 192.168.7.$n/32
$IPTABLES -A POSTROUTING -t nat -j MASQUERADE -s 192.168.7.$dest/32
echo 1 > /proc/sys/net/ipv4/ip_forward
echo 1 > /proc/sys/net/ipv4/conf/$TAP/proxy_arp
$IPTABLES -P FORWARD ACCEPT

echo $TAP
