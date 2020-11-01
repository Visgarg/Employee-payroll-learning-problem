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