DROP DATABASE IF EXISTS sale_manager;
CREATE DATABASE sale_manager;
USE sale_manager;

CREATE TABLE customers(
	customers_id 				INT, 
    first_name					VARCHAR(50),
    last_name					VARCHAR(50),
	email_address				VARCHAR(50),
    number_of_complaints		INT
);

CREATE TABLE sales(
	purchase_number 			INT, 
    date_of_purchase			DATE,
    customer_id					INT,
	item_code					VARCHAR(10)
);

CREATE TABLE items(
	item_code 					INT, 
    item						VARCHAR(50),
    unit_price_usd				INT,
    company_id					INT,
    company						VARCHAR(50),
    headquarters_phone_number	VARCHAR(20)
);
