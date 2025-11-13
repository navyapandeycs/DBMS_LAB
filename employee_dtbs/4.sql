create database if not exists emp_database;
show databases;
use emp_database;
create table dept(deptno int, dname varchar(20), dloc varchar(30), primary key(deptno));
insert into dept values(1,"hr","Bengaluru");
insert into dept values(2,"sales","jaipur");
insert into dept values(3,"marketing","delhi");
insert into dept values(4,"dealer","Bengaluru");
insert into dept values(5,"distributer","jaipur");
insert into dept values(6,"IT","mumbai");
select * from dept;

create table project(pno int, ploc varchar(30),pname varchar(20), primary key(pno));
insert into project values(1,"Bengaluru","AB");
insert into project values(2,"mumbai","BC");
insert into project values(3,"jaipur","CD");
insert into project values(4,"Bengaluru","DE");
insert into project values(5,"delhi","EF");
insert into project values(6,"Bengaluru","GH");
select * from project;


create table employee(empno int, ename varchar(20), mgr_no int, hiredate date, sal float, deptno int, primary key(empno), foreign key(deptno) references dept(deptno)); 
insert into employee values(120,"Anya",201,"2003-03-13",30000,1);
insert into employee values(121,"Nikhil",203,"2004-04-17",50000,2);
insert into employee values(122,"Amit",205,"2003-09-23",20000,3);
insert into employee values(123,"Asha",204,"2011-12-21",60000,5);
insert into employee values(124,"Maya",124,"2006-05-16",800000,4);
insert into employee values(125,"Piyush",124,"2009-03-25",70000,4);
insert into employee values(126,"Lakshya",203,"2003-07-29",900000,6);
select * from employee;

create table assignedto(empno int,pno int, jobrole varchar(20), foreign key(empno) references employee(empno),foreign key(pno) references project(pno));
insert into assignedto values(120,2,"sales assocciate");
insert into assignedto values(121,5,"supervisor");
insert into assignedto values(122,3,"analyst");
insert into assignedto values(123,1,"junior rep");
insert into assignedto values(124,6,"product manager");
insert into assignedto values(125,6,"software developer");
insert into assignedto values(126,5,"coordinator");

create table incentives(empno int,incentivedate date, incentiveamount int,primary key(incentivedate), foreign key(empno) references employee(empno));
insert into incentives values(120,"2004-03-13",3000);
insert into incentives values(121,"2005-04-17",5000);
insert into incentives values(122,"2006-09-23",3000);
insert into incentives values(123,"2012-12-21",6000);
insert into incentives values(124,"2007-05-16",8000);
insert into incentives values(125,"2009-05-16",NULL);
insert into incentives values(126,"2001-05-16",NULL);
drop table incentives;

select e.empno,p.ploc from assignedto e, project p where e.pno=p.pno and p.ploc in("Bengaluru","jaipur");
select empno from employee where empno not in(select empno from incentives);
select e.ename,e.empno,d.dname,a.job_role,d.dloc as department_location,p.ploc as project_location from employee e join dept d on e.deptno=d.deptno join assignedto a on e.empno=a.empno join project p on a.pno=p.pno where d.dloc=p.ploc;

select m.ename as manager_name from employee m join employee e on e.mgr_no=m.empno group by m.empno having count(e.empno)=(select max(emp_count) from (select count(empno) as emp_count from employee where mgr_no is not null group by mgr_no)t);

select a.ename as manager_name from employee a join employee b on b.mgr_no=a.empno group by a.empno,a.ename,a.sal having a.sal>avg(b.sal);

select distinct e.deptno, e.ename as second_top_level_manager from employee e join employee m on e.mgr_no = m.empno where m.mgr_no is null;

select e.* from employee e join incentives i on e.empno=i.empno where i.incentive_amount=(select incentive_amount from incentives order by incentive_amount desc limit 1 offset 1) and i.incentive_date like "2019-01%";

select e.empno, e.ename as employee_name, e.deptno, m.ename as manager_name from employee e join employee m on e.mgr_no = m.empno where e.deptno = m.deptno;