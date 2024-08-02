drop table Customer CASCADE constraint;
CREATE table Customer(
 Phone_Number number(10),
 First_Name varchar2(15) not null,
 Last_Name varchar2(15),
 City_Name varchar2(10),
 Zip_Code number(5) not null,
 Street_Name varchar2(20),
 constraint Pk_Customer primary key (Phone_Number));
 
 drop table Shop CASCADE constraint;
 create table Shop(
 Shop_Name varchar2(20),
 Order_State varchar2(20),
 Image varchar2(30),
 constraint Pk_Shop primary key (Shop_Name));
 
 drop table Shop_Type CASCADE constraint;
 create table Shop_Type (
 Type varchar2(20) not null,
 Shop_Name varchar2(20),
 constraint Pk_ShopType primary key (Type),
 constraint FK_Shop_Type foreign key (Shop_Name) references Shop (Shop_Name));
 
 -------------------------------------------------------------------------------------------
 
 
drop table Ordeer CASCADE constraint;
create table ordeer (
order_ID char(4),
Date1 date,
Payment varchar2(10),
Quantity number(5),
Phone_Number number(10),
Shop_Name varchar2(20),
constraint Ordeer_pk primary key (order_ID),
constraint Ordeer_FK_Phone_Number foreign key (Phone_Number) references Customer(Phone_Number),
constraint Ordeer_FK_Shop_Name foreign key (Shop_Name) references Shop(Shop_Name));


drop table Product CASCADE constraint;
create table Product (
Title VARCHAR2(10) UNIQUE ,
Price NUMBER(8),
Image varchar2(20),
Product_ID char(4),
Shop_Name varchar2(20),
constraint Product_pk primary key (Product_ID),
constraint Product_FK_Shop_Name foreign key (Shop_Name) references Shop(Shop_Name));

drop table Driver CASCADE constraint;
create table Driver (
Driver_ID char(4) primary key,
Order_State varchar2(20),
Driver_Phone_Number varchar2(10) not null ,
Vehicle_Type varchar2(20),
Driver_Name varchar2(20) NOT NULL);


-------------------------------------------------------------------------------


drop table  Rate CASCADE constraint;
CREATE TABLE Rate (
Driver_ID CHAR(4),
Phone_Number NUMBER(10),
NUMBER_of_stars NUMBER(5),
constraint Rate_pk primary key (Driver_ID,Phone_Number),
CONSTRAINTS Rate_Driver_ID_FK FOREIGN KEY (Driver_ID) REFERENCES Driver(Driver_ID), 
CONSTRAINTS Rate_Phone_Number_FK FOREIGN KEY (Phone_Number) REFERENCES Customer(Phone_Number));


drop table  Deliver CASCADE constraint;
CREATE table Deliver (
Phone_Number NUMBER(10),
Order_ID char(4),
Driver_ID CHAR(4),
constraint Deliver_pk primary key (Phone_Number,Order_ID),
CONSTRAINTS Ordeer_ID_FK FOREIGN KEY (Order_ID) REFERENCES Ordeer(Order_ID),
CONSTRAINTS Driver_ID_FK FOREIGN KEY (Driver_ID) REFERENCES Driver(Driver_ID), 
CONSTRAINTS Phone_Number_FK FOREIGN KEY (Phone_Number) REFERENCES Customer (Phone_Number));


-------------------------------------------------

insert into Customer
values(0549813309,'Joud','Alrajeh','Riyadh',19823,'alaliani');

insert into Customer
values(0598741223,'Ghala','Alswailem','khobar',12987,'anas bin malik');

insert into Customer
values(0530007707,'Layan','Alenzi','Makkah',23976,'alsabeel');




insert into Shop
values('black barn','preparing',null);

insert into Shop
values('cacti cafe','Delivery in progress',null);

insert into Shop
values('Easy bakery','Delivered',null);




insert into Shop_Type
values('burger restaurant','black barn');

insert into Shop_Type
values('coffee shop','cacti cafe');

insert into Shop_Type
values('bakery','Easy bakery');



insert into ordeer
values('1123','24-feb-2018','card', 3, 0549813309,'black barn');

insert into ordeer
values('1145','9-may-2023','cash', 5, 0598741223,'cacti cafe');

insert into ordeer
values('1167','6-dec-2023','card', 20, 0530007707,'Easy bakery');



insert into Product
values('Buffalo', 32, null, '789','black barn');

insert into Product
values('V60', 20, null,'456','cacti cafe');

insert into Product
values('Cinnamon', 14, null, '123','Easy bakery');




insert into Driver
values('1042', 'preparing', 0559997554, 'motorcycle', 'adeel');

insert into Driver
values('1067', 'Delivery in progress', 0598741223, 'car', 'nasser');

insert into Driver
values('1099', 'Delivered', 0530007707, 'car', 'waad');





insert into Rate
values('1042', 0549813309, 3);

insert into Rate
values('1067', 0598741223, 4);

insert into Rate
values('1099', 0530007707, 5);




insert into Deliver
values(0549813309,'1123' , '1042');

insert into Deliver
values(0598741223,'1145' , '1067');

insert into Deliver
values(0530007707,'1167' , '1099');



--------------------------------------------------------

--WHERE

--list customer who lives in anas bin malilk street
SELECT First_Name
FROM Customer
WHERE Street_Name LIKE 'anas bin malik';



--list the price if it greater than or equal 20 
SELECT price 
FROM product
WHERE price >=20.0;


--Find all orders(by ID) that order before 6/12/2023
SELECT order_ID,Date1 
FROM ordeer
WHERE Date1 <'6-dec-2023';

--------------------------------------------
--group by

----------to count how many !!!!!!!!!!!!!!!!------
select Title,count(Product_ID)
from Product
group by Title;



--having 
select order_ID, sum (Quantity)
from ordeer
group by order_ID
having sum(Quantity)>3; 



--Subquerie
SELECT Product_ID, Price 
    FROM Product
    WHERE Price > (SELECT AVG(Price)
	FROM product); 