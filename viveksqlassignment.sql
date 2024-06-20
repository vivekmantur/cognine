--1--1. Write a script to extracts all the numerics from Alphanumeric String
use vivek_273;

DECLARE @num NVARCHAR(25);
SET @num= 'VIV123EK53##522';

WHILE PATINDEX('%[^0-9]%', @num) != 0
BEGIN
    SET @num = REPLACE(@num, SUBSTRING(@num, PATINDEX('%[^0-9]%', @num), 1), '');
END

SELECT @num;


--2--Write a script to calculate age based on the Input DOB
select datediff(yy,'2002/01/20',getdate());


--3--Create a column in a table and that should throw an error when we do SELECT * or SELECT of that column. If we select other columns then we should see results
alter table product add discount as CAST('1' AS INT)
select productid from product;


--5--Display Emp and Manager Hierarchies based on the input till the topmost hierarchy. (Input would be empid)
--Output: Empid, empname, managername, heirarchylevel
 create table employ(empid int,empname varchar(30),managerid int);
 insert into employ values(121,'ravi',NULL),(122,'ram',121),(123,'hari',122),(124,'giri',122);
 select * from employ;
 truncate table employ;

with hier as
(
  select empid,empname,managerid,1 as hierarchylevel from employ where empid=122
  union all
  select e.empid, e.empname, e.managerid,h.hierarchylevel+1 from employ e
    INNER JOIN hier h ON e.EmpID =h.managerid
)
SELECT h.empid,h.empname,e.empname,h.hierarchylevel
from hier h
LEFT JOIN employ e ON h.managerid = e.empid;

--4--



