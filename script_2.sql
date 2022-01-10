use sales;

CREATE TABLE items (
    item_code VARCHAR(255) PRIMARY KEY,
    item VARCHAR(255),
    unit_price NUMERIC(10 , 2 ),
    company_id VARCHAR(255)
);

CREATE TABLE companies (
    company_id VARCHAR(255) PRIMARY KEY,
    company_name VARCHAR(255),
    headquaters_phone_number INT(12)
);

drop table sales;

CREATE TABLE sales (
    purchase_number INT AUTO_INCREMENT PRIMARY KEY,
    date_of_purchase DATE,
    customer_id INT,
    item_code VARCHAR(10),
    FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id)
        ON DELETE CASCADE
);

drop table sales;
drop table customers;
drop table items;
drop table companies;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_address VARCHAR(255),
    number_of_complaints INT,
    PRIMARY KEY (customer_id)
);

alter table customers add column gender enum('M', 'F') after last_name;

insert into customers (first_name, last_name, gender, email_address, number_of_complaints) 
values('John', 'Mackinley', 'M', 'john.mckinley(@)365careers.com', 0);

select * from customers;

alter table customers change column number_of_complaints number_of_complaints int default 0;

insert into customers(first_name, last_name, gender) 
values('Peter', 'Figaro', 'M');

select * from customers;

CREATE TABLE companies (
    company_id VARCHAR(255),
    company_name VARCHAR(255) DEFAULT 'X',
    headquarters_phone_number VARCHAR(255),
    UNIQUE KEY (headquarters_phone_number)
);

alter table companies add primary key (company_id);

drop table companies;

CREATE TABLE companies (
    company_id VARCHAR(255),
    company_name VARCHAR(255) DEFAULT 'X',
    headquarters_phone_number VARCHAR(255),
    UNIQUE KEY (headquarters_phone_number)
);



alter table companies change column headquarters_phone_number headquarters_phone_number varchar(255) not null;

alter table companies modify headquarters_phone_number varchar(255) null;

