create database study;
use study;

create table student (
	student_id int primary key auto_increment,
    name varchar(30) not null,
    major varchar(20) unique
);

create table student (
	student_id int primary key auto_increment,
    name varchar(30),
    major varchar(20) default 'undecided'
);

describe student;
drop table student;

alter table student add gpa decimal(3, 2);
alter table student drop gpa;

select * from student;

insert into student(name, major) values('Jack', 'Biology');
insert into student(name, major) values('Kate', 'Sociology');
insert into student(name, major) values("Claire", 'Chemistry');  
insert into student(name, major) values('Jack', 'Biology');
insert into student(name, major) values('Mike', 'Computer Science');

update student set major = 'Bio' where major = 'Biology' or major = 'Chemistry';

