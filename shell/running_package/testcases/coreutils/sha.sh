#!/bin/bash
# author: datnd
#=====================================================================================================
# DESCRIPTION: Testing for generating of digest functions by sha1sum, sha224sum, sha256sum, sha384sum, 
#              sha512sum commands. Input for testing is "sample.txt" with content "Hello world".
#=====================================================================================================

RESULT=1
EXP_OUTPUT_STEP_1="33ab5639bfd8e7b95eb1d8d0b87781d4ffea4d5d"
EXP_OUTPUT_STEP_2="75efd2a4a9e3b000642e38fa6ae9d2d718c91f776269414f29d70083"
EXP_OUTPUT_STEP_3="1894a19c85ba153acbf743ac4e43fc004c891604b26f8c69e1e83ea2afc7c48f"
EXP_OUTPUT_STEP_4="d4af6c43fda3ca958c7bf6140dc3ce448e3bfe3c02c9c5b212e43020aeb200bdc9014c6bd40102b7fb96423d2211e6d5"
EXP_OUTPUT_STEP_5="81381f1dacd4824a6c503fd07057763099c12b8309d0abcec4000c9060cbbfa67988b2ada669ab4837fcd3d4ea6e2b8db2b9da9197d5112fb369fd006da545de"

# run step 1
OUTPUT_STEP_1=`sha1sum   ${data_dir}/sample.txt` 2> ${log_file}
echo -e "OUTPUT_STEP_1:\n""${OUTPUT_STEP_1}" >> ${log_file}
if [ -n "`echo "${OUTPUT_STEP_1}" | grep "${EXP_OUTPUT_STEP_1}"`" ]
then
        echo "STEP 1 PASSED" >> ${log_file}
else
        RESULT=0
        echo "STEP 1 FAILED" >> ${log_file}
fi

# run step 2
OUTPUT_STEP_2=`sha224sum  ${data_dir}/sample.txt` 2>> ${log_file}
echo -e "OUTPUT_STEP_2:\n""${OUTPUT_STEP_2}" >> ${log_file}
if [ -n "`echo "${OUTPUT_STEP_2}" | grep "${EXP_OUTPUT_STEP_2}"`" ]
then
        echo "STEP 2 PASSED" >> ${log_file}
else
        RESULT=0
        echo "STEP 2 FAILED" >> ${log_file}
fi

# run step 3
OUTPUT_STEP_3=`sha256sum  ${data_dir}/sample.txt` 2>> ${log_file}
echo -e "OUTPUT_STEP_3:\n""${OUTPUT_STEP_3}" >> ${log_file}
if [ -n "`echo "${OUTPUT_STEP_3}" | grep "${EXP_OUTPUT_STEP_3}"`" ]
then
        echo "STEP 3 PASSED" >> ${log_file}
else
        RESULT=0
        echo "STEP 3 FAILED" >> ${log_file}
fi

# run step 4
OUTPUT_STEP_4=`sha384sum  ${data_dir}/sample.txt` 2>> ${log_file}
echo -e "OUTPUT_STEP_4:\n""${OUTPUT_STEP_4}" >> ${log_file}
if [ -n "`echo "${OUTPUT_STEP_4}" | grep "${EXP_OUTPUT_STEP_4}"`" ]
then
        echo "STEP 4 PASSED" >> ${log_file}
else 
        RESULT=0
        echo "STEP 4 FAILED" >> ${log_file}
fi

# run step 5
OUTPUT_STEP_5=`sha512sum  ${data_dir}/sample.txt` 2>> ${log_file}
echo -e "OUTPUT_STEP_5:\n""${OUTPUT_STEP_5}" >> ${log_file}
if [ -n "`echo "${OUTPUT_STEP_5}" | grep "${EXP_OUTPUT_STEP_5}"`" ]
then
        echo "STEP 5 PASSED" >> ${log_file}
else
        RESULT=0
        echo "STEP 5 FAILED" >> ${log_file}
fi


# check result after running all steps
assert_passed ${RESULT} 1
