# Streamlit HOL Setup

# Step 1: Acquiring Source Data from the Snowflake Marketplace

  * Log into your Snowflake account and set the role to the ACCOUNTADMIN role
  
  * Click → Data Products → Marketplace
  
  * Search → cybersyn
  
  * Click → Finance & Economics
  
  * Under Options dropdown
  
  * Grant to Additional Roles → PUBLIC
  
  * Click → Get
  
  * This will create a logical database from the marketplace data share listing
  

# Step 2: Create the Role, Warehouse, Schema & User for each HOL user

  * Run the script Streamlit_HOL_Setup
  
  * Creates a utility db
  
  * Creates a stored procedure to execute sql n times based on n of users
    
  * Set the initial password in the line of code: "set lab_pwd = ''; -- enter initial password here"
  
  * Creates a role, warehouse, schema and user such as Schema1, Role1, WH1, User1 for each HOL user
  
  * Grants the necessary privileges to each user for their Sandbox Schema
  
