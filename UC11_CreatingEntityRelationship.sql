--Welcome to Employee payroll sql program

--creating database uc1
create database employee_payroll;

use employee_payroll;

--Creating employee_payroll table in UC2
create table employee_payroll 
(
-- id is not null and auto incremented
id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
-- name is not null
name varchar(150) not null,
-- salary is of float data type and not null
salary float NOT NULL,
-- start is a date type and not null
start date not null
);
-- identity(1,1) is autoincrement for id, 1 starting, another 1 is gap

--inserting data into the table  UC3
Insert into employee_payroll(name, salary, start)
values
('kohli',32828,'2018-01-03'),
('rohit',22828,'2018-03-03'),
('dhoni',39828,'2017-11-03');

--selecting all data from database UC4
select * from employee_payroll;

--retrieving specific data from particular employee UC5
select name, salary from employee_payroll where name='kohli'; 

--selecting all the columns from employee_payroll table with where condition for date.
select * from employee_payroll where start between cast('2019-03-03' as date) and getdate();


--used to get current date with time.
select getdate();
-- below format is used to get only date, otherwise getdate returns date and time
--converts get date into only date part.
select convert(date,getdate());
-- casts getdate as date
select cast(getdate() as date);
--used to get time from getdate
SELECT CONVERT(time, getdate())

--used to alter table employee_payroll by adding one more column  UC6
alter table employee_payroll
add gender char(1);
--checking for adding columns
select * from employee_payroll;
-- used to update payroll table and entered gender for name in where conditoin
update employee_payroll set gender='F' where name='kohli';

update employee_payroll set gender='M' where name='dhoni' or name='rohit';

select * from employee_payroll;

-- used to get summary data using group by clause. UC7
select gender, avg(salary) from employee_payroll where gender='F' group by gender;

select gender, count(*) from employee_payroll group by gender;

select count(name) from employee_payroll;

select gender, sum(salary) from employee_payroll group by gender;

select min(salary) as "Lowest Salary" from employee_payroll;

select max(salary) Highest_Salary from employee_payroll;

select name, salary from employee_payroll where salary= (select max(salary) from employee_payroll);


--adding phone number, address and department into the table UC8
select * from employee_payroll;

alter table employee_payroll add  phone_number int;

alter table employee_payroll add address varchar(150) default 'bangalore';

alter table employee_payroll add department varchar(150) not null default 'HR';

alter table employee_payroll
alter column phone_number bigint;

update employee_payroll
set phone_number =8527419632, address= 'hisar',department='IT'
where name='kohli';

update employee_payroll
set phone_number =8447419632, address= 'Gurgaon'
where name='dhoni';

update employee_payroll
set phone_number=9415825892, address='bangalore'
where name='rohit';

select * from employee_payroll;

--method to create stored procedure
create procedure custom_retreiveEmployee
as
select * from employee_payroll
go;

exec custom_retreiveEmployee;


-- using stored procedure to update name of columns 
--creating columns deductions, taxable pay, net pay and income tax UC9
Exec sp_rename 'employee_payroll.salary','Base_pay','COLUMN';

alter table employee_payroll add Deductions float , Taxable_pay float,Net_pay float,Income_Tax float 

update employee_payroll
set deductions= 100, taxable_pay = 200, net_pay= base_pay-300, income_tax= 0.1*(base_pay)
where name='rohit' or name='dhoni';

select * from employee_payroll

update employee_payroll
set deductions=50, taxable_pay=100, net_pay= base_pay-200, income_tax=0.15*(base_pay)
where name='kohli';

-- adding same name to with differnt department and same other attributes to same table
-- employee id becomes different, hence it means there are 2 different employees with same name  uc10
insert into employee_payroll
values('kohli','32828','2018-01-03','F',8527419632,'hisar','Maintainence',50,100,32628,4964.2) ;

update employee_payroll
set income_tax= 0.15*(base_pay)
where id=4;

select * from employee_payroll;
---creating different table for normalization and adding data into them
--removing redundant data from employee_payroll table
use employee_payroll;
--created company table with company id and company name as attributes
create table company
(company_id int primary key,
companyName varchar(50) not null);
--inserted data into company table
insert into company
values(101, 'Capgemini India');
--altering table employee payroll to add company id column
alter table employee_payroll
add company_id int not null default 101;
--adding department table
create table departments
(departmentID int primary key,
departmentName varchar(50) not null,
noOfEmployees int ,
headOfDepartment varchar(50) not null);
--adding data into department table
insert into departments
values
(01,'IT',29,'Mr. Vishal Garg'),(02,'HR',35,'Shilpa'),(03,'Maintainence',5,'Lakshay');

insert into departments(departmentID,departmentName,headOfDepartment)
values(04,'Sales','Mahak Singla'),(05,'Marketing','Kavita Singh');
--creating employee department table
create table EmployeeDepartment
(employeeID int not null, departmentID int not null);
--selecting data from employee payroll
select * from employee_payroll;
--inserting data into employee department which acts a link between employee and department to cater many to many relation ship between them
insert into EmployeeDepartment
values
(1,01),(2,02),(3,02),(1,03);
--deleting redundant data from employee payroll
delete from employee_payroll
where name='kohli' and department='Maintainence';

select * from employee_payroll;
--dropping department column from employee payroll
alter table employee_payroll drop constraint DF__employee___depar__37A5467C;
alter table employee_payroll drop column department;
--renaming table name from employee payroll to employee using stored procedure
exec sp_rename 'employee_payroll', 'employee'
--creating table payroll
create table payroll
(employeeID int not null primary key, basepay decimal not null, deductions decimal not null, taxable_pay decimal not null,
tax decimal not null, netPay decimal not null);

select * from employee;
--inserting data into payroll
insert into payroll
values
(1,50000,5000,45000,1000, 44000),(2,100000,10000,90000,2000,88000),(3,300000,30000,270000,20000,250000);
--altering table employee to delete columns of payroll
alter table employee
drop column base_pay;

alter table employee
drop column deductions,
taxable_pay,
net_pay,
income_tax;

