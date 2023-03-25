# Crowdfunding_ETL

## ETL mini project

Team:
Rachel Novak
Martha Griggs

You will work with a partner to practice building an ETL pipeline using Python, Pandas and either Python dictionary methods or regular expressions to extract and transform the data. After you transform the data, you'll create four CSV files and use the CSV file data to create an ERD and a table schema. Finally, you'll upload the CSV file data into a Postgres database. 

## Create the Category and Subcategory DataFrames
1. Extract and transform the `crowdfunding.xlsx` Excel data to create a category DataFrame that has the following columns:
   * A category_id column that has entries going sequentially from 'cat1' to 'catn', where n is the number of unique categories
   * A category column that contains only the category titles
2. Export the category DataFrame as `category.csv` and save it to your GitHub repository. 
3. Extract and transform the `crowdfunding.xlsx` Excel data to create a subcategory DataFrame that has the following columns:
   * A subcategory_id column that has entries going sequentially from 'subcat1' to 'subcatn', where n is the number of unique categories
   * A subcategory column that contains only the subcategory titles
   
4. Export the category DataFrame as `subcategory.csv` and save it to your GitHub repository. 

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
   
3. 
   
   
   
