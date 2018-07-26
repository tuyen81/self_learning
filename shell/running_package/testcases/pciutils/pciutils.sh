#!/bin/bash
#==============================================================================
# DISCRIPTION: The lspci command is to display information
#              about all PCI buses and devices in the system.
#              It is based on a common portable library libpci which offers access
#              to the PCI configuration space on a variety of operating systems.
#              The actual output is compared with expected output to give result.
#==============================================================================

#Declare expected output
HOST_BRIDGE="Host bridge"
ISA_BRIDGE="ISA bridge"
IDE_INTERFACE="IDE interface"
VGA_CONTROLLER="VGA compatible controller"
ETHERNET_CONTROLLER="Ethernet controller"

#Generate map file modules.pcimap
depmod -m

#Run command lspci and stored result to pciutils.log file
lspci > ${log_file} 2>&1

#Check result of command lspci with expected output 
if [ -n "`cat ${log_file} | grep "${HOST_BRIDGE}"` && `cat ${log_file} | grep "${ISA_BRIDGE}"` && `cat ${log_file} | grep "${IDE_INTERFACE}"` && `cat ${log_file} | grep "${VGA_CONTROLLER}"` && `cat ${log_file} | grep "${ETHERNET_CONTROLLER}"`" ]
then
  echo "${test_passed_text}" >> ${RESULT_FILE}
else
  echo "${test_failed_text}" >> ${RESULT_FILE}
fi
