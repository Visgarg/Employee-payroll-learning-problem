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