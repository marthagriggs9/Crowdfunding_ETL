# Crowdfunding_ETL

## ETL mini project

Team:

Rachel Novak

Martha Griggs

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

## Create the Campaign DataFrame
1. Extract and transform the `crowdfunding.xlsx` Excel data to create a campaign DataFrame that has the following columns:
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
   
2. Export the campaign DataFrame as `campaign.csv` and save it to your GitHub repository.

## Create the Contacts DataFrame
1. Choose one of the following two options for extracting and transforming the data from `contacts.xlsx` Excel data:
   * Option 1: Use Python dictionary methods
   * Option 2: Use regular expressions
   
2. If you choose Option 1, complete the following steps:
   * Import the `contacts.xlsx` file into a DataFrame
   * Iterate through the DataFrame, converting each row to a dictionary
   * Iterate through each dictionary, doing the following:
     * Extract the dictionary values from the keys by using a Python list comprehension
     * Add the values for each row to a new list
     
   * Create a new DataFrame that contains the extracted data
   * Split each 'name' column value intoa first and last name and place each in a new column
   * Clean and export the DataFrame as `contacts.csv` and save it to your GitHub repository
   
3. If you chose Option 2, complete the following steps:
   * Import the `contacts.xlsx` file into a DataFrame
   * Extract the 'contact_id', 'name' and 'email' columns by using regular expressions
   * Create a new DataFrame with the extracted data
   * Convert the 'contact_id' column to the integer type
   * Split each 'name' column value into a first and a last name and place each in a new column
   * Clean and then export the DataFrame as `contacts.csv` and save it to your GitHub repository

## Create Crowdfunding Database

1. Inspect the four CSV files and then sketch an ERD of the tables
2. Use the information from the ERD to create a table schema for each CSV file
3. Save the database schema as a Postgres file named `crowdfunding_db_schema.sql` and save it to your GitHub repository
4. Create a new Postgres database, named `crowdfunding_db`
5. Using the database schema, create the tables in the correct order to handle the foreign keys
6. Verify the table creation by running a `SELECT` statement for each table
7. Import each CSV file into its corresponding SQL table
8. Verify that each table has the correct data by running a `SELECT` statement for each
   
   
   
