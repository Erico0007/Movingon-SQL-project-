
USE MovinOn_Team10;


Create view EmployeesEarning as 

Select
EmpID,
EmpFirst,
EmpLast,
Salary
HourlyRate, 
CASE 
        WHEN salary = 'Salaried' THEN salary
        WHEN HourlyRate = 'HourlyRate' THEN salary * 2080
        ELSE 0
    END AS annual_salary
FROM 
    employees;
    
    
Select*from EmployeesEarning;

Create view EmployeesYearsOfServices as 
Select
EmpID,
EmpFirst,
EmpLast,
StartDate,
DOB,
 TIMESTAMPDIFF(YEAR, startdate, CURDATE()) AS yearsofservice,
    TIMESTAMPDIFF(YEAR, dob , CURDATE()) AS age
FROM 
    employees;
    
    select*from EmployeesYearsOfServices;
    
    
    Create view WarehouseManagerReportLabels as 
    select
    E.EmpID,
    E.EmpFirst as ManagerFirstName,
	E.EmpLast  as ManagerLastName,
    E.Address,
    E.City,
    E.State,
    E.Zip,
    E.Phone, 
    W.WarehouseID,
    CONCAT(e.EmpFirst, '', e.EmpLast, ' (', w.warehouseID, ')') AS managernamewithwarehouse
    FROM employees e
    JOIN positions p ON e.PositionID = p.PositionID
    JOIN WAREHOUSES W ON E.warehouseID = W. WAREHOUSEID
    WHERE P.TITLE = 'Manager'
    ;
    
    select* from WarehouseManagerReportLabels;
    
    create view  JobRevenueReport as 
    Select
    jd.JobID,
    jo.MoveDate,
    CONCAT (d.DriverFirst, ' ', d.DriverLast) AS DriverFullName,
    d.MileageRate,
    jd.MilageActual,
    jd.WeightActual,
    (milageactual * 0.7 + weightactual * 0.2) AS income,
    (jd.MilageActual * d.MileageRate + 50) AS DriverPayment,
    ((milageactual * 0.7 + weightactual * 0.2) - (jd.MilageActual * d.MileageRate + 50)) AS netincome
    from 
    jobdetails jd
    JOIN
    joborders jo ON jd.JobID = jo.JobID
    JOIN
    drivers d ON jd.DriverID = d.DriverID;
    
    select* from JobRevenueReport;
    
    
    
    CREATE VIEW StorageRevenueReport AS
    select 
    u.WarehouseID,
    CONCAT(c.ContactLast, ', ', c.ContactFirst) AS RenterFullName,
     u.UnitID,
     u.UnitSize,
	 u.Rent,
     r.DateIn,
     r.DateOut,
     DATEDIFF(COALESCE(r.DateOut, CURDATE()), r.DateIn) AS DaysRented,
     ROUND(u.Rent * (DATEDIFF(COALESCE(r.DateOut, CURDATE()), r.DateIn) / 30), 2) AS TotalRent,
     NULL AS TotalWarehouseRent
     FROM
      unitrentals r
     JOIN
      customers c ON r.CustID = c.CustID
     JOIN
	 storageunits u ON r.UnitID = u.UnitID AND r.WarehouseID = u.WarehouseID
     
     union all 
     SELECT
u.WarehouseID,
'Total' AS RenterName,
NULL AS UnitID,
NULL AS UnitSize,
NULL AS Rent,
NULL AS DateIn,
NULL AS DateOut,
NULL AS DaysRented,
NULL AS TotalRent,
ROUND(SUM(u.Rent * (DATEDIFF(COALESCE(r.DateOut, CURDATE()), r.DateIn) / 30)), 2) AS TotalWarehouseRent
FROM
unitrentals r
JOIN
storageunits u ON r.UnitID = u.UnitID AND r.WarehouseID = u.WarehouseID
GROUP BY
u.WarehouseID

union all 
select 
'Grand Total' AS WarehouseID,
NULL AS RenterName,
NULL AS UnitID,
NULL AS UnitSize,
NULL AS Rent,
NULL AS DateIn,
NULL AS DateOut,
NULL AS DaysRented,
NULL AS TotalRent,
ROUND(SUM(u.Rent * (DATEDIFF(COALESCE(r.DateOut, CURDATE()), r.DateIn) / 30)), 2)
AS TotalWarehouseRent
FROM
unitrentals r
JOIN
storageunits u ON r.UnitID = u.UnitID;

select * from StorageRevenueReport;

Create view  LongTermRentals as 
select 
u.WarehouseID,
CONCAT(c.ContactLast, ', ', c.ContactFirst) AS RenterFullName,
u.UnitID,
u.UnitSize,
u.Rent,
r.DateIn,
r.DateOut,
DATEDIFF(COALESCE(r.DateOut, CURDATE()), r.DateIn) AS DaysRented,
ROUND(DATEDIFF(COALESCE(r.DateOut, CURDATE()), r.DateIn) / 365.25, 1) AS YearsRented,
ROUND(u.Rent * (DATEDIFF(COALESCE(r.DateOut, CURDATE()), r.DateIn) / 30), 2) AS TotalRent,
NULL AS TotalWarehouseRent
FROM
unitrentals r
JOIN
customers c ON r.CustID = c.CustID
JOIN
storageunits u ON r.UnitID = u.UnitID AND r.WarehouseID = u.WarehouseID

union all 

SELECT
u.WarehouseID,
'Total' AS RenterName,
NULL AS UnitID,
NULL AS UnitSize,
NULL AS Rent,
NULL AS DateIn,
NULL AS DateOut,
NULL AS DaysRented,
NULL AS YearsRented,
NULL AS TotalRent,
ROUND(SUM(u.Rent * (DATEDIFF(COALESCE(r.DateOut, CURDATE()), r.DateIn) / 30)), 2) AS TotalWarehouseRent
FROM
unitrentals r
JOIN
storageunits u ON r.UnitID = u.UnitID AND r.WarehouseID = u.WarehouseID
GROUP BY
u.WarehouseID

union all 

SELECT
'Grand Total' AS WarehouseID,
NULL AS RenterName,
NULL AS UnitID,
NULL AS UnitSize,
NULL AS Rent,
NULL AS DateIn,
NULL AS DateOut,
NULL AS DaysRented,
NULL AS YearsRented,
NULL AS TotalRent,
ROUND(SUM(u.Rent * (DATEDIFF(COALESCE(r.DateOut, CURDATE()), r.DateIn) / 30)), 2) AS TotalWarehouseRent
FROM
unitrentals r
JOIN
storageunits u ON r.UnitID = u.UnitID;

select * from longtermrentals;







     
     
     
    
    
    
    
    
    
    
    
    
