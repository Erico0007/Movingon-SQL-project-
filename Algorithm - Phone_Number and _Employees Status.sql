USE MovinOn_Team10;

create view EmployeeYearofServiceAndPensionStatus as 
SELECT
EmpID,
EmpFirst,
EmpLast,
StartDate,
EndDate,
case 
When EndDate is null then TIMESTAMPDIFF(YEAR, StartDate, IFNULL(EndDate, CURDATE())) 
else TIMESTAMPDIFF(YEAR, StartDate, EndDate)
end AS YearsOfService,
  Case 
  WHEN EndDate is Null and  TIMESTAMPDIFF(YEAR, StartDate, IFNULL(EndDate, CURDATE())) > 5 
  THEN 'Fully Vested'
  else  'Not Vested'
  end as Eligibility ,
  CASE
  When EndDate is null then 'Hide End Date'
  else 'Hide Review'
  End as field_to_hide 
  
  from employees;
  
  select * from EmployeeYearofServiceAndPensionStatus;
  
  
  Create view EmployeesActivity as
  Select 
EmpID,
EmpFirst,
EmpLast,
StartDate, 
CASE
WHEN EndDate IS NULL THEN NULL
ELSE EndDate
END AS EndDate,
CASE
WHEN EndDate IS NULL THEN 'Active'
ELSE 'Inactive'
END AS Status,
CASE
WHEN EndDate IS NULL THEN TIMESTAMPDIFF(YEAR, StartDate, CURDATE())
ELSE TIMESTAMPDIFF(YEAR, StartDate, EndDate)
END AS YearsOfService,
CASE
WHEN EndDate IS NULL AND TIMESTAMPDIFF(YEAR, StartDate, CURDATE()) >= 5 THEN 'Fully Vested'
ELSE 'Not Vested'
END AS Vested
FROM employees;


select * from EmployeesActivity;

Create view NumberVerification as 

select
EmpID,
EmpFirst,
EmpLast,
Phone,
Cell,
CASE 
        WHEN state = 'Oregon' AND LEFT(phone, 3) NOT IN ('541', '503', '971') THEN 'OR phone area codes should be 541, 503, or 971'
        WHEN state = 'Washington' AND LEFT(phone, 3) NOT IN ('425', '360', '206', '509', '253') THEN 'WA phone area codes should be 425, 360, 206, 509, or 253'
        WHEN state = 'Wyoming' AND LEFT(phone,3) <> '307' THEN 'WY phone area codes should be 307'
        ELSE 'Valid'
        END AS phone_area_code_validation,
        CASE 
        WHEN state = 'Oregon' AND LEFT(Cell, 3) NOT IN ('541', '503', '971') THEN 'OR phone area codes should be 541, 503, or 971'
        WHEN state = 'Washington' AND LEFT(Cell, 3) NOT IN ('425', '360', '206', '509', '253') THEN 'WA phone area codes should be 425, 360, 206, 509, or 253'
        WHEN state = 'Wyoming' AND LEFT(Cell, 3) <> '307' THEN 'WY phone area codes should be 307'
        ELSE 'Valid'
        END AS cell_area_code_validation
        
        from employees;
        
  
  select* from NumberVerification;