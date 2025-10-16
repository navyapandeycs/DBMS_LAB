create database if not exists bank_databse;
show databases;
use bank_databse;

create table branch(branch_name varchar(20), branchcity varchar(30), assests int, primary key(branch_name));
insert into branch values("SBI_Chamrajpet","Bangalore",50000);
insert into branch values("SBI_RecidencyRoad","Bangalore",10000);
insert into branch values("SBI_ShivajiRoad","Bombay",20000);
insert into branch values("SBI_ParliamentRoad","Delhi",10000);
insert into branch values("SBI_Jantarmantar","Delhi",20000);
select * from branch;

create table bankaccount(accno int, branch_name varchar(20), balance int, primary key(accno),
foreign key(branch_name) references branch(branch_name));
insert into bankaccount values(1,"SBI_Chamrajpet",2000);
insert into bankaccount values(2,"SBI_RecidencyRoad",5000);
insert into bankaccount values(3,"SBI_ShivajiRoad",6000);
insert into bankaccount values(4,"SBI_ParliamentRoad",9000);
insert into bankaccount values(5,"SBI_Jantarmantar",8000);
insert into bankaccount values(6,"SBI_ShivajiRoad",4000);
insert into bankaccount values(8,"SBI_RecidencyRoad",5000);
insert into bankaccount values(9,"SBI_ParliamentRoad",3000);
insert into bankaccount values(10,"SBI_RecidencyRoad",5000);
insert into bankaccount values(11,"SBI_Jantarmantar",2000);
select * from bankaccount;
drop table bankaccount;

create table bankcustomer(customername varchar(20), customerstreet varchar(20), customercity varchar(20),primary key(customername));
insert into bankcustomer values("Avinash","Bull_Temple_Road","Bangalore");
insert into bankcustomer values("Dinesh","Bannergatta_Road","Bangalore");
insert into bankcustomer values("Mohan","NationalCollege_Road","Bangalore");
insert into bankcustomer values("Nikil","Akbar_Road","Delhi");
insert into bankcustomer values("Ravi","Prithviraj_Road","Delhi");
select * from bankcustomer;

create table depositer(customername varchar(30),accno int, foreign key(customername) references bankcustomer(customername), foreign key(accno) references bankaccount(accno));
INSERT INTO depositer VALUES ("Avinash", 1);
INSERT INTO depositer VALUES('Dinesh', 2);
INSERT INTO depositer VALUES('Nikil', 4);
INSERT INTO depositer VALUES('Ravi', 5);
INSERT INTO depositer VALUES('Avinash', 8);
INSERT INTO depositer VALUES('Nikil', 9);
INSERT INTO depositer VALUES('Dinesh', 10);
insert into depositer values('Nikil',11);
select * from depositer;
drop table depositer;

create table loan(loannumber int,branch_name varchar(20),amount int,foreign key(branch_name) references branch(branch_name));
INSERT INTO Loan VALUES(1, 'SBI_Chamrajpet', 1000);
INSERT INTO Loan VALUES(2, 'SBI_ResidencyRoad', 2000);
INSERT INTO Loan VALUES(3,'SBI_ShivajiRoad',3000);
INSERT INTO Loan VALUES(4, 'SBI_ParliamentRoad', 4000);
INSERT INTO Loan VALUES(5, 'SBI_Jantarmantar', 5000);
select * from loan;

select branch_name, assests/100000 as 'assests in lakhs' from branch;

SELECT d.customername, ba.branch_name
FROM depositer d
JOIN BankAccount ba ON d.accno = ba.accno
GROUP BY d.customername, ba.branch_name
HAVING COUNT(*) >= 2;

CREATE VIEW BranchLoanSum AS SELECT branch_name, SUM(amount) AS total_loan_amount FROM LOAN
GROUP BY branch_name;
select* from BranchLoanSum;

SELECT DISTINCT c.customername FROM bankcustomer c
JOIN depositer d ON c.customername = d.customername
JOIN bankaccount a ON d.accno = a.accno
JOIN branch b ON a.branch_name = b.branch_name
WHERE c.customercity = 'Delhi';

SELECT DISTINCT customername FROM loan
WHERE customername NOT IN (SELECT customername FROM depositer);

SELECT branch_name FROM branch
WHERE assests > ALL (SELECT assests FROM branch WHERE branchcity = 'Bombay');

UPDATE bankaccount SET balance = balance * 1.05;

DELETE FROM bankaccount WHERE branch_name IN (SELECT branch_name FROM branch
    WHERE branchcity = 'Bombay');











