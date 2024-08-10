/* Purpose: Manage Employee, Driver, Customer,Order Data*/

/* Script Date : July 07 2024 
Developed by : Amon Arnaud Eric Yao Ekra*/

create database MovinOn_TeamNo
;

use MovinOn_TeamNo
;

create table Customers
(
CustomerID int auto_increment not null,
CompanyName varchar (50) not null,
ContactFirst varchar (30) not null,
ContactLast varchar (30) not null,
Adress      varchar (40) not null,
City       varchar (30) not null,
State varchar (2) not null, 
ZIP   varchar (10) not null,
Phone  varchar (15) not null,
Balance decimal  (19,4) not null,
constraint pk_Customers primary key (CustomerID asc) 
)
;

Create table JobOrders
(
JobID INT AUTO_INCREMENT NOT NULL,
CustomerID INT NOT NULL,
MoveDate  datetime not null,
FromAdress varchar (50)  not null ,
FromCity Varchar (30) not null,
FromState varchar (2) not null,
ToAddress varchar (50) not null,
ToCity varchar (30) not null,
ToState varchar (2) not null,
DistanceEst int not null,
WeightEst int not null,
Packing  tinyint (1) not null,
Heavy    tinyint (1) not null,
storage  tinyint (1) not null,
constraint pk_JobOrders primary key (JobID asc),
foreign key (CustomerID) REFERENCES Customers (CustomerID)
)
;
create table Drivers
(
DriverID INT auto_increment,
DriverFirst varchar	(30) not null,
DriverLast varchar (30) not null,
SSN varchar (9) not null,
DOB datetime not null,
StartDate Datetime not null,
EndDate Datetime not null,
Address varchar (40) not null,
City varchar (30) not null,
State Varchar (2) not null,
ZIP Varchar (10) not null, 
Phone varchar (15) not null,
Cell varchar (15) not null,
MileageRate decimal (19,4) not null,
Review datetime not null,
DrivingRecords varchar (1) not null,
constraint pk_driver primary key (DriverID asc),
    constraint ck_zip_driver CHECK (Zip like '^[0-9]*$'),
    constraint ck_phone_driver CHECK (Phone like '^[0-9]*$'),
    constraint ck_cell_driver CHECK (Cell like '^[0-9]*$'),
    constraint ck_ssn_driver CHECK (SSN like '^[0-9]{3}-[0-9]{3}-[0-9]{3}$'),
    constraint uq_ssn_driver UNIQUE (SSN)
)
;

Create table vehicles
(
VehicleID varchar (10)  not null,
LicencePlateNum varchar (7) not null,
Axle int not null,
color varchar (10) not null,
constraint pk_vehicles primary key (VehicleID asc)
)
;

create table jobDetails 
(
JobID INT auto_increment not null,
VehicleID varchar (10) not null,
DriverID INT NOT NULL,
MileageActual int not null,
WeightActual int not null,
constraint pk_jobDetails primary key (JobID asc),
foreign key (vehicleID) references VEHICLES (vehicleID),
foreign key (DriverID) references Drivers (DriverID)
)
;

create table  Warehouses
(
WarehouseID varchar (5) not null,
Address varchar (40) not null,
City varchar (30) not null,
State Varchar (2) not null,
ZIP Varchar (10) not null,
Phone varchar (15) not null,
ClimateControl tinyint (1) not null,
SecurityGate tinyint (1) not null,
constraint pk_warehouses primary key (WarehouseID asc),
    constraint ck_zip_warehouse CHECK (Zip like '^[0-9]*$'),
    constraint ck_phone_warehouse CHECK (Zip like '^[0-9]*$'),
    constraint ck_cell_warehouse CHECK (Zip like '^[0-9]*$')
)
;

create table Storageunits
(
UnitID INT auto_increment not null,
WarehouseID varchar (5) not null,
UnitSize varchar (10) not null,
Rent Decimal (19,4) not null,
constraint pk_Storageunits Primary key (UnitID ASC),
foreign key (WarehouseID) references Warehouses	(WarehouseID)
)
;

create table Unitrentals
(
CustomerID int auto_increment not null,
WarehouseID varchar (5) not null,
UnitID INT  not null,
DateIN DATETIME NOT NULL,
DateOut datetime not null,
constraint pk_Customers primary key (CustomerID asc),
foreign key (WarehouseID) references Warehouses	(WarehouseID)
)
;

Create table Employees
(
EmpID INT auto_increment NOT NULL,
EmpFirst varchar  (30) not null,
EmpLast varchar (30) not null,
WarehouseID varchar (5) not null,
SSN varchar (9) not null,
DOB datetime not null,
StartDate Datetime not null,
EndDate Datetime not null,
Address varchar (40) not null,
City varchar (30) not null,
State Varchar (2) not null,
ZIP Varchar (10) not null,
Position int not null, 
Memo longtext not null ,
Phone varchar (15) not null,
Cell varchar (15) not null,
Salary decimal (19,4) not null,
HourlyRate Decimal (19,4) not null,
Review datetime not null,
constraint pk_employees primary key (EmpID asc),
    constraint ck_zip_employees CHECK (Zip like '^[0-9]*$'),
    constraint ck_phone_employees CHECK (Phone like '^[0-9]*$'),
    constraint ck_cell_employees CHECK (Cell like '^[0-9]*$'),
    constraint ck_ssn_employees CHECK (SSN like '^[0-9]{3}-[0-9]{3}-[0-9]{3}$'),
    constraint uq_ssn_employees UNIQUE (SSN),
    foreign key (WarehouseID) references Warehouses(WarehouseID)
)
;



drop table Positions;


create table Position
(
PositionID int auto_increment not null,
Title varchar (30) not null,
EmpID INT NOT NULL,
constraint pk_Position primary key (PositionID),
foreign key (EmpID) REFERENCES employees (empid)
)
;
