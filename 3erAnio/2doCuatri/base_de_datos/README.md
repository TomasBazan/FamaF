# The setup

I pull both images and set the volumen to the folder BD to have acces inside the container to the specific data.
In mongo: docker run -d -p 27017:27017 --name mongo-labs -v /home/tomas/Documentos/FamaF/3erAnio/2doCuatri/base_de_datos/BD:/data/db mongo:5                                                                             I
In mysql: docker run -d -p 3306:3306 --name mysql-labs -v /home/tomas/Documentos/FamaF/3erAnio/2doCuatri/base_de_datos/BD:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=tomas mysql:8

Note: In mysql have to be excecuted with -uroot flag and of course -p flag to input the password 'tomas'
The complete command is : docker exec -it mysql-container mysql -uroot -p   #(with password=tomas)

---

# How to populate the database 

## Mysql

UUser
Database changed
mysql> \! gunzip -c /tmp/world-data.sql.gz | mysql -u root -p world
Enter password: 
ERROR 1146 (42S02) at line 4: Table 'world.country' doesn't exist

gzip: stdout: Broken pipe
mysql> 

ChatGPT
It seems like the script is trying to insert data into a table (country) that doesn't exist in your world database. This could be due to differences in the structure of the script and the actual database schema.

Here are a few things you can check and try:

Check the Contents of the Script:

Examine the contents of the world-data.sql.gz script to understand its structure and whether it assumes the existence of certain tables.
Check the Database Schema:

After connecting to the MySQL container, check the existing tables in the world database:

sql
Copy code
USE world;
SHOW TABLES;
Ensure that the expected tables, including country, exist in your database.

Modify the Script (if needed):

If the script assumes the existence of tables that are not present, you may need to modify the script to create the required tables before inserting data.
Create Tables Manually (if needed):

If the script is missing table creation statements, you might need to create the tables manually based on your specific lab requirements.
sql
Copy code
USE world;
-- Create tables as needed
CREATE TABLE country (
    -- Define columns
);
Replace -- Define columns with the actual column definitions from the script.

Once you've made the necessary adjustments, try running the script again:

bash
Copy code
docker exec -it mysql-labs mysql -u root -p world < /tmp/world-data.sql
Replace mysql-labs with the actual name of your MySQL container. This command reads the script directly without the need for decompression. If you've addressed any missing tables or modified the script accordingly, this should populate your database successfully.ser
Database changed
mysql> \! gunzip -c /tmp/world-data.sql.gz | mysql -u root -p world
Enter password: 
ERROR 1146 (42S02) at line 4: Table 'world.country' doesn't exist

gzip: stdout: Broken pipe
mysql> 

ChatGPT
It seems like the script is trying to insert data into a table (country) that doesn't exist in your world database. This could be due to differences in the structure of the script and the actual database schema.

Here are a few things you can check and try:

Check the Contents of the Script:

Examine the contents of the world-data.sql.gz script to understand its structure and whether it assumes the existence of certain tables.
Check the Database Schema:

After connecting to the MySQL container, check the existing tables in the world database:

sql
Copy code
USE world;
SHOW TABLES;
Ensure that the expected tables, including country, exist in your database.

Modify the Script (if needed):

If the script assumes the existence of tables that are not present, you may need to modify the script to create the required tables before inserting data.
Create Tables Manually (if needed):

If the script is missing table creation statements, you might need to create the tables manually based on your specific lab requirements.
sql
Copy code
USE world;
-- Create tables as needed
CREATE TABLE country (
    -- Define columns
);
Replace -- Define columns with the actual column definitions from the script.

Once you've made the necessary adjustments, try running the script again:

bash
Copy code
docker exec -it mysql-labs mysql -u root -p world < /tmp/world-data.sql
Replace mysql-labs with the actual name of your MySQL container. This command reads the script directly without the need for decompression. If you've addressed any missing tables or modified the script accordingly, this should populate your database successfully.
## MongoDB

docker exec -it mongo-labs mongorestore --host localhost --drop --gzip --db mflix /scripts/mongodb/lab1/mflix/
