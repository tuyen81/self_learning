sed -e 's/\s*\(.*\).*/\1/' << EOF | sqlite3 company.db
  create table employee(empid integer,name varchar(20),title varchar(10));
  create table department(deptid integer,name varchar(20),location varchar(10));
  .quit
EOF
