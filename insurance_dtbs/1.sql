create database IF NOT exists insurance_database;

show databases;
use insurance_database;
create table car(reg_num varchar(10),model varchar(10),year int, primary key(reg_num));
insert into car values ("KA052250", "Indica", 1990);
insert into car values ("KA031181",	"Lancer",1957);
insert into car values ("KA095477","Toyota",1998);
insert into car values ("KA053408",	"Honda", 2008);
insert into car values ("KA041702","Audi",2005);
select * from car;

                                       
create table accident(report_num int, accident_date date, location varchar(20),primary key(report_num));
insert into accident values (11, "2003-01-01","Mysore Road");
insert into accident values (12,"2004-02-02","South end Circle");
insert into accident values (13,"2003-01-21","Bull temple Road");
insert into accident values (14,"2008-02-17","Mysore Road");
insert into accident values (15,"2004-03-05","Kanakpura Road");
select * from accident;

create table person (driver_id varchar(10),
name varchar(20),  address varchar(30), primary key(driver_id));
insert into person values ("A01","Richard","Srinivas nagar");
insert into person values ("A02","Pradeep","Rajaji nagar");
insert into person values ("A03","Smith","Ashok nagar");
insert into person values ("A04","Venu","N R Colony");
insert into person values ("A05","Jhon","Hanumanth nagar");
select * from person;

create table owns(driver_id varchar(10),reg_num varchar(10),
primary key(driver_id, reg_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num));
insert into owns values ("A01","KA052250");
insert into owns values ("A02","KA053408");
insert into owns values ("A03","KA031181");
insert into owns values ("A04","KA095477");
insert into owns values ("A05","KA041702");
select * from owns;

create table participated(driver_id varchar(10), reg_num varchar(10),
report_num int, damage_amount int, 
primary key(driver_id, reg_num, report_num), 
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num),
foreign key(report_num) references accident(report_num));
insert into participated values ("A01","KA052250",11,10000);
insert into participated values ("A02","KA053408",12,50000);
insert into participated values ("A03","KA095477",13,25000);
insert into participated values ("A04","KA031181",14,3000);
insert into participated values ("A05","KA041702",15,5000);
select * from participated;

update participated set damage_amount=25000 
where reg_num='KA053408' and report_num=12;
update person set name="riya" where driver_id='A02' and address='Rajaji Nagar';

select * from car order by year asc;
select count(model) CNT from car c, participated p, accident a where c.model="Lancer" and c.reg_num=p.reg_num and p.report_num=a.report_num;
select * from participated order by damage_amount desc;
select avg(damage_amount) from participated;
delete from participated where damage_amount<(select avg_amt from(select avg(damage_amount) as avg_amt from participated)as t);
select name from person a, participated b where a.driver_id=b.driver_id and damage_amount>(select avg(damage_amount) from participated);
select max(damage_amount) from participated;
update participated set damage_amount=25000 where reg_num="KA053408" and report_num=12;
insert into accident values(16,"2008-03-15","domlur");


