https://github.com/rchardptrsn/MSSQL-Docker-Container/blob/master/import-data.sh

https://www.abhith.net/blog/create-sql-server-database-from-a-script-in-docker-compose/

https://blog.christian-schou.dk/dockerize-net-core-web-api-with-ms-sql-server/

https://www.softwaredeveloper.blog/initialize-mssql-in-docker-container

https://cardano.github.io/blog/2017/11/15/mssql-docker-container

https://www.twilio.com/blog/containerize-your-aspdotnet-core-application-and-sql-server-with-docker

https://github.com/microsoft/mssql-docker/issues/542

https://medium.com/@clasikas/docker-container-volume-and-mssql-database-b0592a47071f



To connect to any container i use ubuntu machine ip
in windows 10 ----> install wsl2 -----> install ubuntu 22.04 by wsl2
or just use docker-descktop ip address on windows if it has been installed





Ways to Create TestDb in sql

1- first connect to sql 
then create database by application ( await app.EnsureDbCreatedWithSeedData() in program.cs file)


  sql:
    image: mcr.microsoft.com/mssql/server
    container_name: sql
    restart: on-failure
    volumes:
      - /mnt/c/dockerize-dotnet-sql-in-wsl2/sqldata:/var/opt/mssql/data
      # - sqldata:/var/opt/mssql
    environment:
      - SA_PASSWORD=Pass123!
      - ACCEPT_EULA=Y
    ports:
      - "1444:1433"      
    networks:
      - backend 

2- by custom sql server image
create custom sql server image with initialize script and run it by shell file

 sql:
    image: sql
    container_name: sql
    restart: on-failure
    # restart: always
    # user: mssql
    build:
      context: .
      dockerfile: ./src/SqlImage/Dockerfile.db
    volumes:
      - /mnt/c/dockerize-dotnet-sql-in-wsl2/sqldata:/var/opt/mssql/data
      # - sqldata:/var/opt/mssql      
    environment:
      - SA_PASSWORD=Pass123!
      - ACCEPT_EULA=Y
    ports:
      - "1444:1433"      
    networks:
      - backend     



# Dockerfile.db Contents

FROM mcr.microsoft.com/mssql/server

ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=Pass123!

COPY ./src/SqlImage/ /
# COPY ./src/SqlImage/initdb.sql /initdb.sql
# COPY ./src/SqlImage/entrypoint.sh /entrypoint.sh

# Switch to root user to grant write permission  to entrypoint.sh
USER root
# # # # # Grant execute permission to the entrypoint script
RUN chmod +x entrypoint.sh

# Switch back to default user to connect to sql server 
USER mssql


ENTRYPOINT [ "/bin/bash", "entrypoint.sh" ]

CMD [ "/opt/mssql/bin/sqlservr" ]


----------------------------------------

To Add .env file values to dockerfile ,docker-compose file and other file  use beneath command

docker-compose --env-file ./.env up -d
