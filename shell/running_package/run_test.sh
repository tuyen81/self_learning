#!/bin/sh
# Author: Le Tien, TuyenHV
# This file will execute test script
# First, need to read package_test_list.txt
# Then, run testcase.sh in each package
###################################################################################################

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "FATAL: This script must be run as root" 1>&2
   exit 1
fi

# Go to package-test directory if user is running outside
cd `dirname $0` || \
    {
        echo "FATAL: unable to change directory to $(dirname $0)"
        exit 1
    }

# Include the functions.sh file
. ./functions.sh

# main function
main()
{
    setup
    get_arg "$@"
    create_test_cases_list
    run_test
    test_processing
    cleanup
}

main "$@"
