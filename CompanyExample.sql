create database company;
use company;

create table employee(
	emp_id int primary key,
    first_name varchar(40),
    last_name varchar(40),
    birth_date date,
    sex varchar(1),
    salary int,
    super_id int,
    branch_id int
);

create table branch(
	branch_id int primary key,
    branch_name varchar(40),
    mgr_id int,
    mgr_start_date date,
    foreign key(mgr_id) references employee(emp_id) on delete set null
);

# GETTING SUPER_ID AND BRANCH_ID FOREIGN KEYS TO THE EMPLOYEES TABLES
alter table employee
add foreign key(branch_id) references branch(branch_id)
on delete set null;

alter table employee
add foreign key(super_id) references employee(emp_id)
on delete set null;

create table client(
	client_id int primary key,
    client_name varchar(40),
    branch_id int, 
    foreign key(branch_id) references branch(branch_id) on delete set null
);

create table works_with(
	emp_id int,
    client_id int, 
    total_sales int,
    primary key(emp_id, client_id),
    foreign key(emp_id) references employee(emp_id) on delete cascade,
    foreign key(client_id) references client(client_id) on delete cascade
);

create table branch_supplier(
	branch_id int,
    supplier_name varchar(40),
    supply_type varchar(40),
    primary key(branch_id, supplier_name),
    foreign key(branch_id) references branch(branch_id) on delete cascade
);

-- EMPLOYEES
insert into employee values(100, "David", "Wallace", "1967-11-17", "M", 250000, null, null);
insert into branch values(1, "Corporate", 100, "2006-02-09");
update employee set branch_id = 1 where emp_id = 100;

insert into employee values(101, "Jan", "Levinson", "1961-05-11", "F", 110000, 100, 1);

insert into employee values(102, "Michal", "Scott", "1964-03-15", "M", 75000, null, null);
insert into branch values(2, "Scranton", 102, "1992-04-06");
update employee set branch_id = 2 where emp_id = 102;
update employee set super_id = 100 where emp_id = 102;

insert into employee values(103, "Angela", "Martin", "1971-06-25", "F", 63000, 102, 2);
insert into employee values(104, "Kelly", "Kapoor", "1988-02-05", "F", 55000, 102, 2);
insert into employee values(105, "Stanley", "Hudson", "1958-02-19", "M", 69000, 102, 2);

insert into employee values(106, "Josh", "Porter", "1969-09-05", "M", 78000, null, null);
insert into branch values(3, "Stanford", 106, "1998-02-13");
update employee set branch_id = 3 where emp_id = 106;
update employee set super_id = 100 where emp_id = 106;

insert into employee values(107, "Andy", "Bernard", "1973-07-22", "M", "65000", 106, 3);
insert into employee values(108, "Jim", "Halpert", "1978-10-01", "M", "71000", 106, 3);

-- BRANCH SUPPLIER
insert into branch_supplier values(2, "Hammer Mill", "Paper");	
insert into branch_supplier values(2, "Uni-ball", "Writing Utensils");
insert into branch_supplier values(3, "Patriot Paper", "Paper");
insert into branch_supplier values(2, "J.T. Forms & Labels", "Custom Labels");
insert into branch_supplier values(3, "Hammer Mill", "Paper");	
insert into branch_supplier values(3, "Stanford Labels", "Custom Forms");	


-- CLIENT
insert into client values(400, "Dunmore Highschool", 2);
insert into client values(401, "Lackawana Country", 2);
insert into client values(402, "Fedex", 3);
insert into client values(403, "John Daly Law", 3);
insert into client values(404, "Scranton Whitepages", 2);
insert into client values(405, "Times Newspapes", 3);
insert into client values(406, "Fedex", 2);
insert into client values(407, "John Daly Law, LLC", 3);

-- WORKS_WITH 
insert into works_with values(105, 400, 55000);
insert into works_with values(102, 401, 267000);
insert into works_with values(108, 402, 225000);
insert into works_with values(107, 403, 5000);
insert into works_with values(108, 403, 12000);
insert into works_with values(105, 404, 33000);
insert into works_with values(107, 405, 26000);
insert into works_with values(102, 406, 15000);
insert into works_with values(105, 406, 130000);
 
 
-- SHOWING TABLES 
select * from employee;
select * from works_with;


-- FIND ALL EMPLOYEES ORDERED BY SALARY
select * from employee order by salary;
select * from employee order by salary desc;

-- FIND ALL EMPLOYEES ORDERED BY SEX THEN NAME
select * from employee order by sex, first_name, last_name;

-- FIND THE FIRST 5 EMPLOYEES IN THE TABLE
select * from employee limit 5;  

-- FIND THE FIRST AND LAST NAME OF ALL EMPLOYEES
select first_name, last_name from employee;

-- FIND THE forename AND surnames NAMES OF ALL EMPLOYEES
select first_name as forename, last_name as surname from employee;

-- FIND OUT ALL THE DIFERRENT GENDERS
select distinct sex from employee;

-- FIND THE NUMBER OF EMPLOYEES
select count(emp_id) from employee; 

-- FIND THE NUMBER OF FEMALE EMPLOYEES BORN AFTER 1970
select count(emp_id) from employee where sex = "F" and birth_date > "1971-01-01";  

-- FIND THE AVERAGE OF ALL EMPLOYEE'S SALARIES
select avg(salary) from employee where sex = "M";

-- FIND THE SUM OF ALL EMPLOYEE'S SALARIES
select sum(salary) from employee;  

-- FIND OUT HOW MANY MALES AND FEMALES THERE ARE
select count(sex), sex from employee group by sex;

-- FIND THE TOTAL SALES OF EACH SALESMAN
select sum(total_sales), emp_id from works_with group by emp_id;
 
-- FIND THE TOTAL SPENDS OF EACH CLIENT
select sum(total_sales), client_id from works_with group by client_id;

-- WILDCARDS

-- FIND ANY CLIENT'S WHO ARE AN LLC
select * from client where client_name like "%LLC"; 

-- FIND ANY BRANCH SUPPLIERS WHO ARE IN THE LABEL BUSINESS
select * from branch_supplier where supplier_name like "%Labels%";

-- FIND ANY EMPLOYEE BORN IN OCTOBER
select * from employee where birth_date like "____-02%";

-- FIND ANY CLIENTS WHO ARE SCHOOLS
select * from client where client_name like "%school%"; 

 
-- UNION
-- FIND A LIST OF EMPLOYEE AND BRANCH NAMES
select first_name from employee 
union
select branch_name from branch
union
select client_name from client;
 
select first_name as Company_Name from employee
union
select branch_name from branch
union
select client_name from client;

-- FIND A LIST OF ALL CLIENTS CLIENTS & BRANCH SUPPLIERS NAMES
select client_name, branch_id from client union
select supplier_name, branch_id from branch_supplier; 

-- FIND A LIST OF ALL MONEY SPENT OR EARNED BY THE COMPANY
select salary from employee union 
select total_sales from works_with;

-- JOINS
insert into branch values(4, "Buffalo", null, null);
select * from branch;

-- FIND ALL BRANCHES AND THE NAMES OF THEIR MANAGERS
select employee.emp_id, employee.first_name, branch.branch_name
from employee
join branch
on employee.emp_id = branch.mgr_id;

-- LEFT JOIN
select employee.emp_id, employee.first_name, branch.branch_name
from employee
left join branch
on employee.emp_id = branch.mgr_id;

-- RIGHT JOIN 
select employee.emp_id, employee.first_name, branch.branch_name
from employee
right join branch
on employee.emp_id = branch.mgr_id;

-- NESTED QUERIES

-- FIND NAMES OF ALL EMPLOYEES WHO HAVE SOLD OVER 30,000
-- TO A SINGLE CLIENT
select emp_id from works_with where works_with.total_sales > 30000;
  
 select employee.first_name, employee.last_name from employee
 where employee.emp_id IN(
	select works_with.emp_id from works_with where works_with.total_sales > 30000
 );
 
--  FIND ALL CLIENTS WHO ARE HANDLE BY THE BRANCH
--  THAT MICHAEL SCOTT MANAGES, ASSUME YOU KNOW MICHEAL'S ID  
select branch.branch_id from branch where branch.mgr_id = 102;

select client.client_name from client where client.branch_id = (
	select branch.branch_id 
    from branch 
    where branch.mgr_id = 102
    limit 1
);

-- ON DELETE 
delete from employee where emp_id = 102;
select * from branch;
select * from employee;

delete from branch
where branch_id = 2;







