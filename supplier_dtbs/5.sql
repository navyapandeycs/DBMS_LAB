CREATE DATABASE if not exists Supplier_1 ;
USE Supplier_1;

CREATE TABLE Suppliers(SID INT(5), SNAME varchar(20), CITY varchar(20), primary key(SID));
INSERT INTO Suppliers VALUES(10001,"Acme Widget","BANGALORE");
INSERT INTO Suppliers VALUES(10002,"Johns","KOLKATA");
INSERT INTO Suppliers VALUES(10003,"Vimal","MUMBAI");
INSERT INTO Suppliers VALUES(10004,"Reliance","DELHI");
select* from Suppliers;

create table Parts(PID INT primary key, pname varchar(20),color varchar(10));
INSERT INTO Parts VALUES(20001,"BOOK","RED");
INSERT INTO Parts VALUES(20002,"PEN","RED");
INSERT INTO Parts VALUES(20003,"PENCIL","GREEN");
INSERT INTO Parts VALUES(20004,"MOBILE","GREEN");
INSERT INTO Parts VALUES(20005,"CHARGER","BLACK");
select* from Parts;

CREATE TABLE Catalog(SID INT, PID INT, COST float(6),foreign key(SID) references Suppliers(SID), 
foreign key(PID) references Parts(PID), primary key(SID,PID));
INSERT INTO  Catalog VALUES(10001,20001,10);
INSERT INTO  Catalog VALUES(10001,20002,10);
INSERT INTO  Catalog VALUES(10001,20003,30);
INSERT INTO  Catalog VALUES(10001,20004,10);
INSERT INTO  Catalog VALUES(10001,20005,10);
INSERT INTO  Catalog VALUES(10002,20001,10);
INSERT INTO  Catalog VALUES(10002,20002,20);
INSERT INTO  Catalog VALUES(10003,20003,30);
INSERT INTO  Catalog VALUES(10004,20003,40);

SELECT distinct P.pname from Parts P,Catalog C where P.pid=C.pid;

SELECT S.sname FROM Suppliers S JOIN Catalog C ON S.sid = C.sid GROUP BY S.sname
HAVING COUNT(DISTINCT C.pid) = (SELECT COUNT(*) FROM Parts);

SELECT S.sname FROM Suppliers S JOIN Catalog C ON S.sid = C.sid JOIN Parts P ON C.pid = P.pid
WHERE P.color = 'Red' GROUP BY S.sname 
HAVING COUNT(DISTINCT P.pid) = (SELECT COUNT(*) FROM Parts WHERE color = 'Red');

SELECT P.pname FROM Parts P JOIN Catalog C ON P.pid = C.pid JOIN Suppliers S ON C.sid = S.sid
GROUP BY P.pid, P.pname HAVING COUNT(DISTINCT S.sname) = 1 AND MAX(S.sname) = 'Acme Widget';
   
SELECT DISTINCT C.sid FROM Catalog C WHERE C.cost>(SELECT AVG(C1.cost) FROM Catalog C1 
WHERE C1.pid =C.pid);

SELECT P.pid,S.sname FROM Parts P, Suppliers S, Catalog C WHERE C.pid=P.pid AND C.sid=S.sid
 AND C.cost= (SELECT MAX(C1.cost) FROM Catalog C1 WHERE C1.pid=P.pid);