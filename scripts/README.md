# Use myScript.sql to view the compilation of scripts that I ran to import the data, create the databases, tables and for data manipulation.
# There are a total of 4 tables, all linked with a foreign key to the primary patron table
# I adjusted the names of the rows of the excel spreadsheet then saved the file as a .csv for importation
# if required here are the column names patron_type_code, patron_type_def, checkout_total, renewal_total, age_range, home_library_code, home_library_def, circ_active_month, circ_active_year, notification_code, notification_type, provided_email, within_SanFranCounty, year_registered
# The initial table was a combined table with all data, this was called library_usage



# Database Scripts

This folder contains all the initialization scripts that helps us (perhaps convert and) load the Excel sheet into the database tables.

The scripts that are used to modify (indexing, moving, updating, data cleaning, ...) the database tables (after the data is loaded into the database) are also included here.
