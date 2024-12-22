create table emp(
id integer primary key ,
name varchar(30),
age integer,
dept_code integer,
office_loc varchar(100),
salary integer default 0
);
insert into emp values (1,'张三',22,1,'宝安',6000),
(2,'李四',31,1,'宝安',7000),
(3,'王五',25,2,'福田',6000),
(4,'赵六',24,1,'宝安',5000),
(5,'庄七',22,3,'光明',8000),
(6,'康八',45,2,'福田',15000),
(7,'聂九',34,3,'光明',7500),
(8,'刘二麻子',56,4,'光明',17000),
(9,'孙小毛',17,1,'宝安',3000),
(10,'陈老大',37,1,'宝安',7000);

-- 原子性
BEGIN;
DELETE from emp where age <17;
UPDATE emp SET salary=salary+1000 where id=5;
select * from emp;
COMMIT ;
select * from emp;
BEGIN;
DELETE from emp where name = '张三';
UPDATE emp SET salary=salary-1000 where id=6;
select * from emp;
ROLLBACK;
select * from emp;

-- 一致性

select * from emp;
BEGIN TRANSACTION ;
UPDATE emp SET salary=salary+1000 where id=5;
SAVEPOINT sp01;
UPDATE emp SET salary=salary-1000 where id=6;
select * from emp;
ROLLBACK TO sp01;
select * from emp;

-- 隔离性

--console1
show default_transaction_isolation;

BEGIN TRANSACTION ;
insert into emp values (11,'张三1',22,1,'宝安',6000);
select * from emp;
COMMIT;
select * from emp;

-- console2
select * from emp;

-- 持久性

BEGIN TRANSACTION ;
TRUNCATE emp;
COMMIT;
select * from emp;--empty table
ROLLBACK;
select * from emp;--still empty

