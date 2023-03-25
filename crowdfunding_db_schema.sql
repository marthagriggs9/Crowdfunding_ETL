--DROP tables if they exist
DROP TABLE campaign;
DROP TABLE contacts;
DROP TABLE category;
DROP TABLE subcategory;

-- creating tables from data
--creating contacts table
CREATE TABLE contacts(
		contact_id INT NOT NULL,
		first_name VARCHAR NOT NULL, 
		last_name VARCHAR NOT NULL,
	    email VARCHAR NOT NULL,
		PRIMARY KEY (contact_id)
);


--view contacts table
SELECT *
FROM contacts;


--creating category table
CREATE TABLE category(
		category_id VARCHAR NOT NULL,
		category VARCHAR NOT NULL, 
		PRIMARY KEY (category_id)
);

-- view category table
SELECT *
FROM category; 

--creating subcategory table
CREATE TABLE subcategory(
		subcategory_id VARCHAR NOT NULL, 
		subcategory VARCHAR NOT NULL, 
		PRIMARY KEY (subcategory_id)
);

--view subcategory table
SELECT * 
FROM subcategory 

--create campaign table
CREATE TABLE campaign(
		cf_id INT NOT NULL, 
		contact_id INT NOT NULL, 
		company_name VARCHAR NOT NULL,
		description VARCHAR NOT NULL, 
		goal FLOAT NOT NULL, 
		pledged FLOAT NOT NULL, 
		outcome VARCHAR NOT NULL, 
		backers_count INT NOT NULL, 
		country VARCHAR NOT NULL, 
		currency VARCHAR NOT NULL, 
		launch_date DATE NOT NULL, 
		end_date DATE NOT NULL, 
		category_id VARCHAR NOT NULL, 
		subcategory_id VARCHAR NOT NULL, 
		FOREIGN KEY (contact_id) REFERENCES contacts (contact_id), 
		FOREIGN KEY (category_id) REFERENCES category (category_id), 
		FOREIGN KEY (subcategory_id) REFERENCES subcategory (subcategory_id),
		PRIMARY KEY (cf_id)
);

SELECT * 
FROM campaign