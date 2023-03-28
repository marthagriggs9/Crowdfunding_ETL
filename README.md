# Crowdfunding_ETL

## ETL mini project

Team:

Rachel Novak

Martha Griggs

Our project submission: [ETL_Mini_Project.ipynb](https://github.com/marthagriggs9/Crowdfunding_ETL/blob/main/ETL_Mini_Project_MGriggs_RNovak.ipynb)

You will work with a partner to practice building an ETL pipeline using Python, Pandas and either Python dictionary methods or regular expressions to extract and transform the data. After you transform the data, you'll create four CSV files and use the CSV file data to create an ERD and a table schema. Finally, you'll upload the CSV file data into a Postgres database. 

## Create the Category and Subcategory DataFrames
1. Extract and transform the `crowdfunding.xlsx` Excel data to create a category DataFrame that has the following columns:
```ruby
# Import dependencies
import pandas as pd
import numpy as np
pd.set_option('max_colwidth', 400)
```
```ruby
# Read the data into a Pandas DataFrame
crowdfunding_info_df = pd.read_excel('Resources/crowdfunding.xlsx', engine= "openpyxl" )
crowdfunding_info_df.head()
```

![Screenshot 2023-03-27 173214](https://user-images.githubusercontent.com/115905663/228081738-f5317d3e-f8c9-4690-b202-0781bd71378c.png)

```ruby
# Get a brief summary of the crowdfunding_info DataFrame.
crowdfunding_info_df.info()
```

![image](https://user-images.githubusercontent.com/115905663/228081890-4d3be88f-4e4d-4480-bbe4-2f5ca5a70bbe.png)

```ruby
# Get the crowdfunding_info_df columns.
crowdfunding_info_df.columns
```

![image](https://user-images.githubusercontent.com/115905663/228081995-bc0c2b15-c182-4815-86ec-d881d94201d6.png)

```ruby
# Assign the category and subcategory values to category and subcategory columns.
crowdfunding_info_df[['category', 'subcategory']] = crowdfunding_info_df['category & sub-category'].str.split('/', n=1, expand=True)
crowdfunding_info_df
```

![image](https://user-images.githubusercontent.com/115905663/228082116-fecb44b0-0332-4f76-a6cb-ba77975c5f91.png)

   * A category_id column that has entries going sequentially from 'cat1' to 'catn', where n is the number of unique categories
   ```ruby
   # Get the unique categories and subcategories in separate lists.
   categories = crowdfunding_info_df['category'].unique()
   print(categories)
   ```
   ```ruby
   # Get the number of distinct values in the categories and subcategories lists.
   print(len(categories))
   ```
   ```ruby
   # Create numpy arrays from 1-9 for the categories and 1-24 for the subcategories.
   category_ids = np.arange(1, 10)
   print(category_ids)
   ```
   ```ruby
   # Use a list comprehension to add "cat" to each category_id. 
   cat_ids = ['cat' +str(id) for id in category_ids]
   print(cat_ids)
   ```
   * A category column that contains only the category titles
   ```ruby
   # Create a category DataFrame with the category_id array as the category_id and categories list as the category name.
   category_data = {'category_id': cat_ids, 'category': categories}
   ```
   

2. Export the category DataFrame as `category.csv` and save it to your GitHub repository. 
```ruby
category_df = pd.DataFrame(category_data)
category_df
```
![Screenshot 2023-03-27 172841](https://user-images.githubusercontent.com/115905663/228081195-9000b07f-fd52-4653-a02d-e73abc8b6693.png)

```ruby
# Export categories_df and subcategories_df as CSV files.
category_df.to_csv("Resources/category.csv", index=False)
```
[category.csv](https://github.com/marthagriggs9/Crowdfunding_ETL/blob/main/Resources/category.csv)

3. Extract and transform the `crowdfunding.xlsx` Excel data to create a subcategory DataFrame that has the following columns:
  
  * A subcategory_id column that has entries going sequentially from 'subcat1' to 'subcatn', where n is the number of unique categories
  ```ruby
  # Get the unique categories and subcategories in separate lists.
  subcategories = crowdfunding_info_df['subcategory'].unique()
  print(subcategories)
  ```
  ```ruby
  # Get the number of distinct values in the categories and subcategories lists.
  print(len(subcategories))
  ```
  ```ruby
  # Create numpy arrays from 1-9 for the categories and 1-24 for the subcategories.
  subcategory_ids = np.arange(1, 25)
  print(subcategory_ids)
  ```
  ```ruby
  # Use a list comprehension to add "subcat" to each subcategory_id.    
  scat_ids = ['subcat' +str(id) for id in subcategory_ids]
  print(scat_ids)
  ```
  
  * A subcategory column that contains only the subcategory titles
   ```ruby
   # Create a category DataFrame with the subcategory_id array as the subcategory_id and subcategories list as the subcategory name. 
   subcategory_data = {'subcategory_id': scat_ids, 'subcategory': subcategories}
   
   ```
4. Export the category DataFrame as `subcategory.csv` and save it to your GitHub repository. 
```ruby
subcategory_df = pd.DataFrame(subcategory_data)
subcategory_df
```

![image](https://user-images.githubusercontent.com/115905663/228083236-870723f5-73ec-4e13-b55e-0781758561a6.png)

```ruby
# Export categories_df and subcategories_df as CSV files.
subcategory_df.to_csv("Resources/subcategory.csv", index=False)
```
[subcategory.csv](https://github.com/marthagriggs9/Crowdfunding_ETL/blob/main/Resources/subcategory.csv)

## Create the Campaign DataFrame
1. Extract and transform the `crowdfunding.xlsx` Excel data to create a campaign DataFrame that has the following columns:
```ruby
# Create a copy of the crowdfunding_info_df DataFrame name campaign_df. 
campaign_df = crowdfunding_info_df.copy()
campaign_df.head()
```

![image](https://user-images.githubusercontent.com/115905663/228083920-cd6b050a-60f9-476c-8519-648c1838edfe.png)

   * cf_id column
   
   * contact_id column
   
   * company_name column
   
   * blurb column, renamed 'description'
   
   * goal column, converted to the `float` data type
  
   * pledged column, converted to the `float` data type
   
   * outcome column
   
   * backers_count
   
   * country column
   
   * currency column
   
   * launched_at column, renamed 'launch_date' and with UTC times converted to `datetime` format
   
   * deadline column, renamed 'end_date' and with UTC times converted to `datetime` format
   
   * category_id column, with unique identification numbers matching those in the 'category_id' column of the category DataFrame
   
   * subcategory_id column, with unique identification numbers matching those in the 'subcategory_id' column of the subcategory DataFrame
```ruby
# Rename the blurb, launched_at, and deadline columns.
campaign_df.rename(columns= {'blurb': 'description', 
                             'launched_at': 'launch_date', 
                             'deadline': 'end_date'}, inplace= True)

campaign_df.head()
```
![image](https://user-images.githubusercontent.com/115905663/228083998-b26cc27a-2dd6-4431-822e-e3c9cab39b4e.png)

```ruby
# Convert the goal and pledged columns to a `float` data type.
campaign_df['goal'] = campaign_df['goal'].astype(float)
campaign_df['pledged'] = campaign_df['pledged'].astype(float)
campaign_df.head()
```
![image](https://user-images.githubusercontent.com/115905663/228084132-6610ac9e-5c98-4f58-b6d2-dfc15a21cc8e.png)

```ruby
# Check the datatypes
campaign_df.dtypes
```
![image](https://user-images.githubusercontent.com/115905663/228084217-9910f106-94b3-466a-bd6c-8ee53e70d5fb.png)

```ruby
# Format the launched_date and end_date columns to datetime format
from datetime import datetime as dt

campaign_df['launch_date'] = pd.to_datetime(campaign_df['launch_date'], unit='s').dt.strftime('%Y-%m-%d')

campaign_df['end_date'] = pd.to_datetime(campaign_df['end_date'], unit='s').dt.strftime('%Y-%m-%d')

campaign_df.head()
```
![image](https://user-images.githubusercontent.com/115905663/228084325-5ff38c7f-9136-4fb9-b704-f10ec4f33008.png)

```ruby
first_merge = campaign_df.merge(category_df, on='category', how='left')
first_merge.head()
```
```ruby
# Merge the campaign_df with the category_df on the "category" column and 
# the subcategory_df on the "subcategory" column.
campaign_merged_df = first_merge.merge(subcategory_df, on = 'subcategory', how='left')

campaign_merged_df.tail(10)
```
```ruby
# Drop unwanted columns
campaign_cleaned = campaign_merged_df.drop(['staff_pick', 'spotlight', 'category & sub-category', 'category', 'subcategory'], axis = 1)
campaign_cleaned.head()
```

![Screenshot 2023-03-27 175306](https://user-images.githubusercontent.com/115905663/228084712-e25d1710-50d6-43c4-9d13-65695e4e8a5a.png)

2. Export the campaign DataFrame as `campaign.csv` and save it to your GitHub repository.
```ruby
# Export the DataFrame as a CSV file. 
campaign_cleaned.to_csv("Resources/campaign.csv", index=False)
```

[campaign.csv](https://github.com/marthagriggs9/Crowdfunding_ETL/blob/main/Resources/campaign.csv)

## Create the Contacts DataFrame
1. Choose one of the following two options for extracting and transforming the data from `contacts.xlsx` Excel data:
   * Option 1: Use Python dictionary methods
   * Option 2: Use regular expressions

2. If you choose Option 1, complete the following steps:
   
   * Import the `contacts.xlsx` file into a DataFrame
   ```ruby
   # Read the data into a Pandas DataFrame. Use the `header=2` parameter when reading in the data.
   contact_info_df = pd.read_excel('Resources/contacts.xlsx', header=2, engine= "openpyxl")
   contact_info_df.head()
   ```

   ![image](https://user-images.githubusercontent.com/115905663/228085129-a8e8f062-ac3d-474a-a32a-a00d216980ab.png)
   
   * Iterate through the DataFrame, converting each row to a dictionary
   ```ruby 
   import json
   # Iterate through the contact_info_df and convert each row to a dictionary.
   # create two lists one for the keys and one for the values
   dict_values = []
   column_names = []
   ```
   
   * Iterate through each dictionary, doing the following:
     * Extract the dictionary values from the keys by using a Python list comprehension
     * Add the values for each row to a new list
   ```ruby
   # Iterate through the contact_info_df and convert each row to a dictionary.
   # create two lists one for the keys and one for the values
   dict_values = []
   column_names = []
   #Iterate through the DataFrame
   for i, row in contact_info_df.iterrows():
       data = row[0]
       #Convert each row to a Python dictionary
       converted_data = json.loads(data)
       #Use a list comprehension to get the keys from the converted data
       columns = [k for k, v in converted_data.items()]
       #Use a list comprehension to get the values for each row
       row_values = [v for k, v in converted_data.items()]
       #Append the keys and list values to the lists created in step 1
       column_names.append(columns)
       dict_values.append(row_values)
   # Print out the keys and list of values for each row
   print(column_names[0])
   print()
   print(dict_values)
   ```
   * Create a new DataFrame that contains the extracted data
   ```ruby
   # Create a contact_info DataFrame and add each list of values, i.e., each row 
   # to the 'contact_id', 'name', 'email' columns.
   contact_info = pd.DataFrame(dict_values, columns=column_names[0])
   contact_info.head()
   ```
   
   ![image](https://user-images.githubusercontent.com/115905663/228086073-c12dda88-55fd-40f5-bf08-9bc74587547e.png)

   * Split each 'name' column value intoa first and last name and place each in a new column
   ```ruby
   # Create a "first"name" and "last_name" column with the first and last names from the "name" column. 
   contact_info[['first_name', 'last_name']] = contact_info['name'].str.split(' ', n=1, expand=True)

   # Drop the contact_name column
   contacts_df_clean = contact_info.drop('name', axis=1)
   contacts_df_clean.head()
   ```
   
   ![image](https://user-images.githubusercontent.com/115905663/228086280-f9ca9ea5-4900-42f5-825c-5275ef4f8f33.png)


   * Clean and export the DataFrame as `contacts.csv` and save it to your GitHub repository
   ```ruby
   # Reorder the columns
   contacts_df_clean = contacts_df_clean[['contact_id', 'first_name', 'last_name', 'email']]
   contacts_df_clean.head(10)
   ```
   
   ![image](https://user-images.githubusercontent.com/115905663/228086429-ceab3315-dd70-4136-9176-64e084a47bfb.png)
   
   ```ruby
   # Check the datatypes one more time before exporting as CSV file.
   contacts_df_clean.info()
   ```
   
   ![image](https://user-images.githubusercontent.com/115905663/228086572-850d6243-efaf-4ada-b041-15c9c0e702fb.png)
   
   ```ruby
   # Export the DataFrame as a CSV file. 
   contacts_df_clean.to_csv("Resources/contacts.csv", encoding='utf8', index=False)
   ```
  
  [contacts.csv](https://github.com/marthagriggs9/Crowdfunding_ETL/blob/main/Resources/contacts.csv)
   
3. If you chose Option 2, complete the following steps:
   * Import the `contacts.xlsx` file into a DataFrame
   * Extract the 'contact_id', 'name' and 'email' columns by using regular expressions
   * Create a new DataFrame with the extracted data
   * Convert the 'contact_id' column to the integer type
   * Split each 'name' column value into a first and a last name and place each in a new column
   * Clean and then export the DataFrame as `contacts.csv` and save it to your GitHub repository

## Create Crowdfunding Database

1. Inspect the four CSV files and then sketch an ERD of the tables

![crowdfunding_ERD](https://user-images.githubusercontent.com/115905663/228113551-fd540c0e-7565-4578-956d-c6a603c68eca.png)

[crowdfunding_ERD.png](https://github.com/marthagriggs9/Crowdfunding_ETL/blob/main/crowdfunding_ERD.png)

2. Use the information from the ERD to create a table schema for each CSV file

3. Save the database schema as a Postgres file named `crowdfunding_db_schema.sql` and save it to your GitHub repository

[crowdfunding_db_schema.sql](https://github.com/marthagriggs9/Crowdfunding_ETL/blob/main/crowdfunding_db_schema.sql)

4. Create a new Postgres database, named `crowdfunding_db`

5. Using the database schema, create the tables in the correct order to handle the foreign keys

6. Verify the table creation by running a `SELECT` statement for each table
```ruby
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
```
7. Import each CSV file into its corresponding SQL table

8. Verify that each table has the correct data by running a `SELECT` statement for each 

![Screenshot 2023-03-25 142724](https://user-images.githubusercontent.com/115905663/228114466-911a47ae-9ceb-4031-afa2-f9891c83749d.png)

![Screenshot 2023-03-25 143107](https://user-images.githubusercontent.com/115905663/228114490-8769300d-3451-4b18-8b32-df8aebd5b24b.png)

![Screenshot 2023-03-25 142926](https://user-images.githubusercontent.com/115905663/228114520-1cc25ba8-3efb-410e-8a32-a68a393d3d92.png)

![Screenshot 2023-03-25 144610](https://user-images.githubusercontent.com/115905663/228114610-77e3d5fb-a2a2-43d4-a847-84ae58ad9015.png)



   
   
   
