use master
go
create database Shop_db
on
(
name=shop_db,
filename='A:\work_on_ms_sql_server\shop\shop.mdf',
size=100,
filegrowth=100,
maxsize=1000
)
log on
(
name=shop_log,
filename='A:\work_on_ms_sql_server\shop\shop.ldf',
size=100,
filegrowth=100,
maxsize=1000

)
go

use Shop_db
create schema Production;
create schema Sales

create table Sales.customers 
(
customer_id int identity primary key,
first_name varchar(20) not null,
last_name varchar(20)not null,
phone varchar(11) not null unique,
email varchar(20) not null unique,
street varchar(20) not null,
city varchar(20) not null,
state varchar(20) not null,
zip_code varchar(5) not null
);


create table Sales.orders(
order_id int  not null unique,
customer_id int ,
order_status varchar(20) not null,
order_date date not null,
required_data date not null,
shipped_date date not null,
store_id int not null,
staff_id int not null,
constraint orders_pk primary key(order_id),
constraint orders_staff_fk foreign key (staff_id) 
references Sales.staffs (staff_id),
constraint order_customer_fk foreign key(customer_id)
references Sales.customers(customer_id),
constraint order_shore_fk foreign key(store_id)
references Sales.stores(store_id)
);

create table Sales.stores
(
store_id int identity primary key ,
store_name varchar(30) not null unique,
phone varchar(11) not null unique,
email varchar(30) not null unique,
street varchar(20) not null,
city varchar(20) not null,
state varchar(20) not null,
zip_code varchar(5) not null

);

create table Sales.staffs
(
staff_id int identity primary key,
first_name varchar(20) not null,
last_name varchar(20)not null,
phone varchar(11) not null unique,
email varchar(20) not null unique,
active varchar(10) not null,
store_id int references Sales.stores (store_id),
manager_id int 
);

create table Production.categories(
category_id int primary key identity,
category_name varchar(20) not null
)
create table Production.brands(
brand_id int primary key identity,
brand_name varchar(20) not null
);
create table Sales.order_items(
order_id int references Sales.orders(order_id) not null,
item_id int identity primary key,
product_id int references Production.products(product_id) not null,
quentity int not null,
list_price varchar(50) not null,
discount decimal 
) 

create table Production.products(
product_id int identity primary key,
product_name varchar(30) not null,
brand_id int references Production.brands(brand_id) not null,
category_id int references Production.categories(category_id) not null,
model_year varchar(20) not null,
list_price varchar(50) not null
)

create table Production.stocks(
store_id int not null references Sales.stores(store_id),
product_id int not null references Production.products(product_id),
quntity int not null)