#!/bin/sh

# The "assert_diff" function take 4 arguments:
#   $1) Actual output file
#   $2) Expected output file
#   $3) Stdout file
#   $4) Stderr file
assert_diff()
{
  if [[ ! -z ${4} ]]; then
    diff ${1} ${2} > ${3} 2> ${4}
  elif [[ ! -z ${3} ]]; then
    diff ${1} ${2} > ${3} 2>&1
  else 
    diff ${1} ${2}
  fi
}

# The "assert_grep" function take 4 arguments:
#   $1) Pattern for grep
#   $2) Input file for grep
#   $3) Stdout file
#   $4) Stderr file
assert_grep()
{
  if [[ ! -z ${4} ]]; then
    grep -nr ${1} ${2} > ${3} 2> ${4}
  elif [[ ! -z ${3} ]]; then
    grep -nr ${1} ${2} > ${3} 2>&1
  else
    grep -nr ${1} ${2}
  fi

}

# The "assert_passed" function takes 2 arguments:
#   $1) Variable needed to check
#   $2) Value for comparing the variable
assert_passed()
{
  if [ ${1} -eq ${2} ]; then
    echo "${test_passed_text}" >> ${RESULT_FILE}
  else
    echo "${test_failed_text}" >> ${RESULT_FILE}
  fi
}

# Setup environment
setup()
{
    export PWD=`pwd`
    export OUTPUT_DIR=${PWD}/output
    export TESTCASES_DIR=${PWD}/testcases
    export CONFIG_DIR=${PWD}/common_config
    export TMPBASE="/tmp"
    export TMP=`mktemp -d ${TMPBASE}/test-XXXXXXXXXX`
    export PACKAGE_LIST=${PWD}/package_test_list.txt
    export CSV_FILE=${PWD}/output.csv
    export RESULT_FILE=${OUTPUT_DIR}/result.txt
    echo "# This file contains results of testing" > ${RESULT_FILE}
}

usage()
{
    cat <<EOF
    usage: ./run_test.sh [OPTION]... [FILE]...
    -f: file which contains list of packages for testing
    default value is package_test_list.txt

    -o: store the result of testing to a file with csv
    format, default value is output.csv

    Example: ./run_test.sh -f trial_package_test_list.txt -o result.csv
EOF
exit 0
}

get_arg()
{
    while getopts ":f:o:" arg; do
        case "${arg}" in
            f)
                PACKAGE_LIST=${PWD}/${OPTARG}
                ;;
            o)
                CSV_FILE=${PWD}/${OPTARG}
                ;;
            *)
                usage
                ;;
        esac
    done
}

# Create a file contains all test cases to running test
# The test cases are stored in ${TMP}/run_test_list.txt
create_test_cases_list()
{
    # Remove comments
    sed -e "s/#.*//g" ${PACKAGE_LIST} > ${TMP}/package_test_list_nocmt.txt

    ################################################################################################
    ### Find test cases of the packages which are running all testcases
    # Find packages which run all test cases. Line is in format:
    #     package_name: *
    # or  package_name: testcase1 testcase2 * testcase3
    grep ":.*\*" ${TMP}/package_test_list_nocmt.txt | cut -d: -f1 > ${TMP}/pkg_all_test_list.txt

    # Find all test cases of the packages in pkg_all_test_list.txt file
    for i in `cat ${TMP}/pkg_all_test_list.txt`
    do
        # Check if test case folder for package exists
        if [ ! -d ${TESTCASES_DIR}/$i ]; then
            echo "WARN: Test cases for package \"$i\" haven't created yet."
            continue
        fi
        find ${TESTCASES_DIR}/$i/ -maxdepth 1 -name '*.sh' -print >> ${TMP}/run_test_list.txt
    done

    ################################################################################################
    ### Find test cases of the packages which are not running all testcases
    # Exclude all lines with "*"
    grep ":" ${TMP}/package_test_list_nocmt.txt | grep -v ":.*\*" > ${TMP}/pkg_not_all_test_list.txt

    while read line; do
        # trim spaces at the beginning and the end of package
        package=`echo $line | cut -d: -f1 | sed 's/^[[:blank:]]*//;s/[[:blank:]]*$//'`
        testcases=`echo $line | sed -e "s/${package}\s*://g"`

        # Check if test case folder for package exists
        if [ ! -d "${TESTCASES_DIR}/$package" ]; then
            echo "WARN: Test cases for package \"$package\" haven't created yet."
            continue
        fi

        # Check if test case exists
        for testcase in $testcases; do
            if [ -f "${TESTCASES_DIR}/$package/${testcase}.sh" ]; then
                echo "${TESTCASES_DIR}/$package/${testcase}.sh" >> ${TMP}/run_test_list.txt
            else
                echo "WARN: Package \"$package\" does not contain test case \"$testcase\"."
            fi
        done
    done < ${TMP}/pkg_not_all_test_list.txt
}

# Run the test cases in run_test_list.txt file
run_test()
{
    echo '"Package name","Test case name","Abstract","Changed from default configuration","Test result","Remark"' > ${CSV_FILE}
    for i in `cat ${TMP}/run_test_list.txt`
    do
        test_case_name=$(basename $i .sh)
        tmp_dir=$(dirname $i)
        package_name=$(basename $tmp_dir)
        data_dir=${TESTCASES_DIR}/${package_name}/data/${test_case_name}.d
        mkdir -p ${OUTPUT_DIR}/${package_name}
        log_file=${OUTPUT_DIR}/${package_name}/${test_case_name}.log
        test_passed_text="Testing for ${test_case_name} testcase: PASSED"
        test_failed_text="Testing for ${test_case_name} testcase: FAILED"
        . $i
        grep -nr $test_case_name ${OUTPUT_DIR}/result.txt | grep PASSED > /dev/null 2>&1
        if [ $? = "0" ]; then
            test_result=OK
            error_log=""
        else
            test_result=NG
            # Replace double quotation by single quotation mark
            sed -i "s/\"/\'/g" ${OUTPUT_DIR}/${package_name}/${test_case_name}.log
            error_log="$(cat ${OUTPUT_DIR}/${package_name}/${test_case_name}.log)"
        fi
        grep -n "#===" $i | cut -d: -f1 > ${TMP}/comment_line.txt
        begin_line=$(sed -n 1p ${TMP}/comment_line.txt)
        begin_line=$((begin_line+1))
        end_line=$(sed -n 2p ${TMP}/comment_line.txt)
        end_line=$(($end_line-1))
        abstract_content="$(sed -n ${begin_line},${end_line}p $i | cut -d':' -f2 | sed 's/\#\ \ \ \ \ \ \ \ \ \ \ \ \ //g')"
        echo -n "$package_name","$test_case_name", >> ${CSV_FILE}
        echo -n "\"$abstract_content\"", >> ${CSV_FILE}
        echo -n "No", >> ${CSV_FILE}
        echo -n "$test_result", >> ${CSV_FILE}
        echo "\"$error_log\"" >> ${CSV_FILE}
    done
}

# Process results to report the number of test cases passed and failed
test_processing()
{
    current_count=`cat ${OUTPUT_DIR}/result.txt | grep -E ": PASSED" 2>&1 | wc -l`
    echo "The number of test cases PASSED: $current_count"

    current_count=`cat ${OUTPUT_DIR}/result.txt | grep -E ": FAILED" 2>&1 | wc -l`
    echo "The number of test cases FAILED: $current_count"
}


# Clean temporary files
cleanup()
{
    rm -rf ${TMP}
}
