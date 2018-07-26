sed -e 's/\s*\(.*\).*/\1/' << EOF | sqlite3 company.db
  select * from employee;
  .tables
  .quit
EOF
