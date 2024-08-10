USE MovinOn_Team10;

select*from employees;

-- employees working in three different warehouses;
select WarehouseID,EmpID,EmpLast, PositionID,StartDate
from Employees
order by  WarehouseID,EmpID,EmpLast
;
-- employees working by states;
Select  EmpID,EmpFirst, EmpLast,City,State
from employees
order by  EmpID, EmpFirst ,EmpLast,State 
;
-- employees working in a specific year;

Select  EmpID,EmpFirst, EmpLast, positionID, StartDate
from employees
WHERE YEAR (STARTDATE) = 2022
order by EmpID,EmpFirst, EmpLast,StartDate
;

-- EMPLOYEE WORKING WITH A SALARY < 40000
Select EmpID,EmpFirst, EmpLast,PositionID,Salary
from employees
where salary > 45000
order by EmpID,EmpFirst, EmpLast,Salary
;

-- Drivers with a specific record 

select   DriverID, DriverFirst,  DriverLast, DrivingRecord
from Drivers
where DrivingRecord > 'A'
ORDER BY DriverID, DriverFirst,  DriverLast, DrivingRecord
;


