# The setup

I pull both images and set the volumen to the folder BD to have acces inside the container to the specific data.
In mongo: docker run -d -p 27017:27017 --name mongo-labs -v /home/tomas/Documentos/FamaF/3erAnio/2doCuatri/base_de_datos/BD:/data/db mongo:5  I
In mysql: docker run -d -p 3306:3306 --name mysql-labs -v /home/tomas/Documentos/FamaF/3erAnio/2doCuatri/base_de_datos/BD:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=tomas mysql:8

Note: In mysql have to be excecuted with -uroot flag and of course -p flag to input the password 'tomas'
The complete command is : docker exec -it mysql-container mysql -uroot -p #(with password=tomas)

---

# How to populate the database

## Mysql

docker exec -i <docker-image> mysql -u root -ppassword <database> < /path/to/file

## MongoDB

docker exec -it mongo-labs mongorestore --host localhost --drop --gzip --db mflix /scripts/mongodb/lab1/mflix/
