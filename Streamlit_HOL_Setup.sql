USE ROLE ACCOUNTADMIN;

-- create utility DB
create database if not exists utility;

-- create a SP to loop through queries for N users
-- it replaces the placeholder XXX with N in the supplied query
create or replace procedure utility.public.loopquery (QRY STRING, N FLOAT)
  returns float
  language javascript
  strict
as
$$
  for (i = 1; i <= N; i++) {
    snowflake.execute({sqlText: QRY.replace(/XXX/g, i)});
  }


  return i-1;
$$;

----------------------------------------------------------------------------------
-- Set up the HOL environment for the first time
----------------------------------------------------------------------------------
set num_users = 20; --> adjust number of attendees here
set lab_pwd = ''; --> enter initial password here

-- set up the roles
call utility.public.loopquery('create or replace role roleXXX comment = "HOLXXX User Role";', $num_users);


-- set up the users and assign the roles
call utility.public.loopquery('create or replace user userXXX must_change_password=true default_role=roleXXX password="' || $lab_pwd || '";', $num_users);
call utility.public.loopquery('grant role roleXXX to user userXXX;', $num_users);
call utility.public.loopquery('grant role roleXXX to role sysadmin;', $num_users); --role hierarchy


-- set up the warehouses for each user and grant privileges to roles
call utility.public.loopquery('create or replace warehouse whXXX warehouse_size = \'xsmall\' AUTO_SUSPEND = 300;', $num_users);
call utility.public.loopquery('grant all on warehouse whXXX to role roleXXX;', $num_users);

-- create a database for the hands on lab 
create or replace database HOL;

-- set up the schemas for each user and grant privileges
call utility.public.loopquery('create or replace schema HOL.schemaXXX clone HOL.PUBLIC;', $num_users); --create a schema for each user
call utility.public.loopquery('grant usage on database HOL to role roleXXX;', $num_users); --grant usage on db
call utility.public.loopquery('grant ownership on schema HOL.schemaXXX to role roleXXX;', $num_users); --grant ownership on schema
call utility.public.loopquery('GRANT usage ON warehouse whXXX TO ROLE roleXXX', $num_users); --grant usage on wh
call utility.public.loopquery('GRANT CREATE STREAMLIT ON SCHEMA hol.schemaXXX TO ROLE roleXXX', $num_users); --grant create streamlit on schema



