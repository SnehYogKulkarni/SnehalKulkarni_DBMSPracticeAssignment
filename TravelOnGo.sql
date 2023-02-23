drop database if exists travel;
create database travel;
use travel;

drop table if exists Passenger;
create table Passenger (
	pass_id int primary key auto_increment,
	Passenger_name varchar(50) , 
	Category varchar(10),
	Gender varchar(1),
	Boarding_City varchar(25),
	Destination_City varchar(25),
	Distance int,
	Bus_Type varchar(10)
);

desc passenger;

drop table if exists Price;
create table Price (
 Bus_Type varchar(10),
 Distance int,
 Price int
 );
 
 desc Price;
 
insert into passenger  (Passenger_name, Category, Gender, Boarding_City, Destination_City, Distance, bus_type) values ("Sejal","AC","F","Bengaluru","Chennai",350,"Sleeper");
insert into  Passenger (Passenger_name, Category, Gender, Boarding_City, Destination_City, Distance, bus_type) values("Anmol","Non-AC","M","Mumbai","Hyderabad",700,"Sitting");
insert into  Passenger (Passenger_name, Category, Gender, Boarding_City, Destination_City, Distance, bus_type) values("Pallavi","AC","F","Panaji","Bengaluru",600,"Sleeper");
insert into  Passenger (Passenger_name, Category, Gender, Boarding_City, Destination_City, Distance, bus_type) values("Khusboo","AC","F","Chennai","Mumbai",1500,"Sleeper");
insert into  Passenger (Passenger_name, Category, Gender, Boarding_City, Destination_City, Distance, bus_type) values("Udit","Non-AC","M","Trivandrum","panaji",1000,"Sleeper");
insert into  Passenger (Passenger_name, Category, Gender, Boarding_City, Destination_City, Distance, bus_type) values("Ankur","AC","M","Nagpur","Hyderabad",500,"Sitting");
insert into  Passenger (Passenger_name, Category, Gender, Boarding_City, Destination_City, Distance, bus_type) values("Hemant","Non-AC","M","panaji","Mumbai","700","Sleeper");
insert into  Passenger (Passenger_name, Category, Gender, Boarding_City, Destination_City, Distance, bus_type) values("Manish","Non-AC","M","Hyderabad","Bengaluru",500,"Sitting");
insert into  Passenger (Passenger_name, Category, Gender, Boarding_City, Destination_City, Distance, bus_type) values("Piyush","AC","M","Pune","Nagpur",700,"Sitting");

insert into Price values("Sleeper",350,770);
insert into Price values("Sleeper",500,1100);
insert into Price values("Sleeper",600,1320);
insert into Price values("Sleeper",700,1540);
insert into Price values("Sleeper",1000,2200);
insert into Price values("Sleeper",1200,2640);
insert into Price values("Sleeper",1500,2700);
insert into Price values("Sitting",500,620);
insert into Price values("Sitting",600,744);
insert into Price values("Sitting",700,868);
insert into Price values("Sitting",1000,1240);
insert into Price values("Sitting",1200,1488);
insert into Price values("Sitting",1500,1860);

set sql_mode = "";
select * from passenger;
select * from price;

/* 3)	How many females and how many male passengers travelled for a minimum distance of 600 KM s? */

select gender as Gender , count(gender) as `Count` from passenger where distance >=600 group by gender;

/* 4)	Find the minimum ticket price for Sleeper Bus.  */

select min(price)  as Price from price where bus_type = 'Sleeper';

/* 5)	Select passenger names whose names start with character 'S'  */

select pass_id as Pass_Id, passenger_name as Name from passenger where passenger_name like 'S%' ;

/* 6)	Calculate price charged for each passenger displaying Passenger name, Boarding City, 
Destination City, Bus_Type, Price in the output */

select A.pass_id as ID, A.passenger_name as Name, A.Boarding_City as Borading_from, A.Destination_City as Destination, A.Bus_Type, B.price as Price
from passenger A, price B where
A. Bus_Type = B.Bus_Type and A.distance = B.distance order by A.pass_id;

/* 7)	What are the passenger name/s and his/her ticket price 
who travelled in the Sitting bus  for a distance of 1000 KM s  */

select A.pass_id as ID, A.passenger_name as Name, B.price as Price  from 
passenger A, price B where 
A.Bus_Type = "Sitting" and B.Bus_Type = "Sitting" and A.distance = 700 and B.distance = 700  ;

/* 8)	What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?  */

select bus_type As Bus_tpye, price as Price from price where 
distance = (select distance from passenger where passenger_name = "pallavi");

--   OR  --

select bus_type As Bus_tpye, price as Price from price where 
distance = (select distance from passenger where 
(Boarding_City = "Bengaluru" and Destination_City ="Panaji") 
or 
(Boarding_City = "Panaji" and Destination_City ="Bengaluru") );

/* List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order. */

select distinct(distance) from Passenger order by distance desc; 

/* 10)	Display the passenger name and percentage of distance travelled by that passenger
 from the total distance travelled by all passengers without using user variables  */
 
 select passenger_name, distance * 100.0/ (select sum(distance) from passenger) from passenger group by distance;
 
 --  OR -- 
 
 with total as (select sum(distance) as total_distance from passenger)
 select pass_id as ID, passenger_name as Name, (distance/total.total_distance *100) as Percentage_Travel 
 from passenger, total;
 
 /* 11)	Display the distance, price in three categories in table Price
a)	Expensive if the cost is more than 1000
b)	Average Cost if the cost is less than 1000 and greater than 500
c)	Cheap otherwise

 */
 
 select Bus_Type, Distance, Price,
 Case
	  when price >= 1000 then "Expensive"
      when price < 1000 and price > 500 then " Average"
      when price <= 500 then "Cheap"
 End as Cost from price;
	
 
 