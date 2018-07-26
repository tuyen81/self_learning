#!/bin/bash

#===============================================================================
# DESCRIPTION: Create a .sql file and create database with 3 fields
#              Using sqlite 3 to insert .sql file above to database company.db
#              View table and info of databse was filter by one field
#===============================================================================

check=0

# Create new a database
. ${data_dir}/create_database.sh > ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

# View info of database
ls -l company.db | sed 's/[0-9].*\s//g' >> ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

# Insert data to database
sqlite3 company.db < ${data_dir}/insert-data.sql

if [ $? != "0" ]; then
  check=1
fi

# View table in database
. ${data_dir}/view_table_database.sh >> ${log_file} 2>&1

if [ $? != "0" ]; then
  check=1
fi

# Check result of testcase
assert_passed $check 0

# Remove non-necessary file
rm -rf company.db
