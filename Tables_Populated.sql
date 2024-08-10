USE MovinOn_Team10;

LOAD DATA INFILE
'C:/warehouses.csv'
INTO TABLE warehouses
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(WarehouseID, Address, City, State, Zip, Phone,ClimateControl, SecurityGate);

select*from warehouses
;

LOAD DATA INFILE
'C:/Positions.csv'
INTO TABLE Positions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(PositionID,Title);

select*from positions
;

insert into positions
values (7,'President');
select*from employees;



LOAD DATA INFILE 'C:/employees.csv'  INTO TABLE employees
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(EmpID, EmpFirst, EmpLast, Address, City, State, Zip, Phone, Cell, SSN, DOB, StartDate, @EndDate, PositionID, @Salary, @HourlyRate, @Review, Memo, WarehouseID)
SET
EndDate = NULLIF(@EndDate, ''),
Salary = NULLIF(@Salary, ''),
HourlyRate = NULLIF(@HourlyRate, ''),
Review = NULLIF(@Review, '');

LOAD DATA INFILE 'C:/drivers.csv'  INTO TABLE drivers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(DriverID,DriverFirst, DriverLast,SSN,DOB,StartDate,@EndDate, Address, City, State, Zip, Phone, Cell, MileageRate,@Review,DrivingRecord)
SET
Review = NULLIF(@Review, ''),
EndDate = NULLIF(@EndDate, '');

Select*from drivers;

LOAD DATA INFILE 'C:/Vehicles.csv'  INTO TABLE Vehicles
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(VehicleID, LicensePlateNum, AxleNum, Color);

LOAD DATA INFILE 'C:/Storageunits.csv'  INTO TABLE Storageunits
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
( UnitID,UnitSize,WarehouseID,Rent);
select*from StorageUnits;

LOAD DATA INFILE
'C:/Customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(CustID, CompanyName, ContactFirst, ContactLast, Address, City, State, Zip, Phone, Balance);

ALTER TABLE customers DROP CONSTRAINT chk_customers_phone;
ALTER TABLE customers
ADD CONSTRAINT chk_customers_phone CHECK (Phone REGEXP '^[0-9\\(\\)\\-\\s]*$');
select*from customers;

LOAD DATA INFILE
'C:/UnitRentals.csv'
INTO TABLE UnitRentals
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
( CustID, WarehouseID,UnitID, DateIn, @DateOut);
set 
DateOut = NULLIF(@DateOut, '');

select*from unitrentals;

LOAD DATA INFILE 'C:/JobOrders.csv'  INTO TABLE joborders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(JobID, CustID, MoveDate,FromAddress,FromCity,FromState, ToAddress,ToCity,ToState, DistanceEst, WeightEst,Packing,Heavy,Storage);

select*from joborders;


LOAD DATA INFILE 'C:/jobdetails.csv'  INTO TABLE jobdetails
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(JobID,VehicleID, DriverID, MilageActual, WeightActual);

select*from jobdetails;