create database professor;
use professor;

create table teacher(
	carnet varchar(50) not null primary key,
    name varchar(50) not null,
    lastName varchar(50) not null,
    email varchar(50) not null,
    gender varchar(2) not null,
    lecture varchar(50) not null
);
